int* test;
	test = (int*)p;
	*test = 10;
	int t = 100;
	int* x = &t;
	if(fork() == 0){
		if(fork() == 0){
			test = (int*)p;
			*test = 30;
			*x = 130;
			printf(1,"Grand Child: %x, %d, %x, %d\n", test, *test, x, *x);
		}
		else{
			wait();
			p = shm_jared(1,2);
			printf(1, "Child sharing key 1\n");
			test = (int*)p;
			*test = 40;
			*x = 140;
			printf(1, "Child: %x, %d, %x, %d", test, *test, x, *x);
		}
	}
	else{
		wait();
		printf(1, "Before sharing key 1\n");
		printf(1, "Parent: %x, %d, %x, %d", test, *test, x, *x);
		p = shm_jared(1,4);
		printf(1, "After sharing key1\n");
		test = (int *)p;
		printf(1, "Parent: %x, %d, %x, %d", test, *test, x, *x);	
	}




// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    
    int match = -1;
    for(int i = 0; i < PAGES; ++i){
      if(pa == V2P(SharedMem[PAGES])){
        match = 1;
      }

    }
     
    flags = PTE_FLAGS(*pte);
    if(match == -1){
      if((mem = kalloc()) == 0)
        goto bad;
      memmove(mem, (char*)P2V(pa), PGSIZE);
    }
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
      goto bad;
  }
  return d;

bad:
  freevm(d);
  return 0;
}
