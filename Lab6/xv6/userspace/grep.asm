
_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 18             	sub    $0x18,%esp
  14:	8b 01                	mov    (%ecx),%eax
  16:	8b 59 04             	mov    0x4(%ecx),%ebx
  int fd, i;
  char *pattern;

  if(argc <= 1){
  19:	83 f8 01             	cmp    $0x1,%eax
{
  1c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(argc <= 1){
  1f:	7e 76                	jle    97 <main+0x97>
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];
  21:	8b 43 04             	mov    0x4(%ebx),%eax
  24:	83 c3 08             	add    $0x8,%ebx

  if(argc <= 2){
  27:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
  2b:	be 02 00 00 00       	mov    $0x2,%esi
  pattern = argv[1];
  30:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(argc <= 2){
  33:	74 53                	je     88 <main+0x88>
  35:	8d 76 00             	lea    0x0(%esi),%esi
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  38:	83 ec 08             	sub    $0x8,%esp
  3b:	6a 00                	push   $0x0
  3d:	ff 33                	pushl  (%ebx)
  3f:	e8 5e 05 00 00       	call   5a2 <open>
  44:	83 c4 10             	add    $0x10,%esp
  47:	85 c0                	test   %eax,%eax
  49:	89 c7                	mov    %eax,%edi
  4b:	78 27                	js     74 <main+0x74>
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
  4d:	83 ec 08             	sub    $0x8,%esp
  for(i = 2; i < argc; i++){
  50:	83 c6 01             	add    $0x1,%esi
  53:	83 c3 04             	add    $0x4,%ebx
    grep(pattern, fd);
  56:	50                   	push   %eax
  57:	ff 75 e0             	pushl  -0x20(%ebp)
  5a:	e8 c1 01 00 00       	call   220 <grep>
    close(fd);
  5f:	89 3c 24             	mov    %edi,(%esp)
  62:	e8 23 05 00 00       	call   58a <close>
  for(i = 2; i < argc; i++){
  67:	83 c4 10             	add    $0x10,%esp
  6a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  6d:	7f c9                	jg     38 <main+0x38>
  }
  exit();
  6f:	e8 ee 04 00 00       	call   562 <exit>
      printf(1, "grep: cannot open %s\n", argv[i]);
  74:	50                   	push   %eax
  75:	ff 33                	pushl  (%ebx)
  77:	68 70 0a 00 00       	push   $0xa70
  7c:	6a 01                	push   $0x1
  7e:	e8 3d 06 00 00       	call   6c0 <printf>
      exit();
  83:	e8 da 04 00 00       	call   562 <exit>
    grep(pattern, 0);
  88:	52                   	push   %edx
  89:	52                   	push   %edx
  8a:	6a 00                	push   $0x0
  8c:	50                   	push   %eax
  8d:	e8 8e 01 00 00       	call   220 <grep>
    exit();
  92:	e8 cb 04 00 00       	call   562 <exit>
    printf(2, "usage: grep pattern [file ...]\n");
  97:	51                   	push   %ecx
  98:	51                   	push   %ecx
  99:	68 50 0a 00 00       	push   $0xa50
  9e:	6a 02                	push   $0x2
  a0:	e8 1b 06 00 00       	call   6c0 <printf>
    exit();
  a5:	e8 b8 04 00 00       	call   562 <exit>
  aa:	66 90                	xchg   %ax,%ax
  ac:	66 90                	xchg   %ax,%ax
  ae:	66 90                	xchg   %ax,%ax

000000b0 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	57                   	push   %edi
  b4:	56                   	push   %esi
  b5:	53                   	push   %ebx
  b6:	83 ec 0c             	sub    $0xc,%esp
  b9:	8b 75 08             	mov    0x8(%ebp),%esi
  bc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  bf:	8b 5d 10             	mov    0x10(%ebp),%ebx
  c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
  c8:	83 ec 08             	sub    $0x8,%esp
  cb:	53                   	push   %ebx
  cc:	57                   	push   %edi
  cd:	e8 3e 00 00 00       	call   110 <matchhere>
  d2:	83 c4 10             	add    $0x10,%esp
  d5:	85 c0                	test   %eax,%eax
  d7:	75 1f                	jne    f8 <matchstar+0x48>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  d9:	0f be 13             	movsbl (%ebx),%edx
  dc:	84 d2                	test   %dl,%dl
  de:	74 0c                	je     ec <matchstar+0x3c>
  e0:	83 c3 01             	add    $0x1,%ebx
  e3:	83 fe 2e             	cmp    $0x2e,%esi
  e6:	74 e0                	je     c8 <matchstar+0x18>
  e8:	39 f2                	cmp    %esi,%edx
  ea:	74 dc                	je     c8 <matchstar+0x18>
  return 0;
}
  ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ef:	5b                   	pop    %ebx
  f0:	5e                   	pop    %esi
  f1:	5f                   	pop    %edi
  f2:	5d                   	pop    %ebp
  f3:	c3                   	ret    
  f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 1;
  fb:	b8 01 00 00 00       	mov    $0x1,%eax
}
 100:	5b                   	pop    %ebx
 101:	5e                   	pop    %esi
 102:	5f                   	pop    %edi
 103:	5d                   	pop    %ebp
 104:	c3                   	ret    
 105:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000110 <matchhere>:
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	56                   	push   %esi
 115:	53                   	push   %ebx
 116:	83 ec 0c             	sub    $0xc,%esp
 119:	8b 45 08             	mov    0x8(%ebp),%eax
 11c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(re[0] == '\0')
 11f:	0f b6 18             	movzbl (%eax),%ebx
 122:	84 db                	test   %bl,%bl
 124:	74 63                	je     189 <matchhere+0x79>
  if(re[1] == '*')
 126:	0f be 50 01          	movsbl 0x1(%eax),%edx
 12a:	80 fa 2a             	cmp    $0x2a,%dl
 12d:	74 7b                	je     1aa <matchhere+0x9a>
  if(re[0] == '$' && re[1] == '\0')
 12f:	80 fb 24             	cmp    $0x24,%bl
 132:	75 08                	jne    13c <matchhere+0x2c>
 134:	84 d2                	test   %dl,%dl
 136:	0f 84 8a 00 00 00    	je     1c6 <matchhere+0xb6>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 13c:	0f b6 37             	movzbl (%edi),%esi
 13f:	89 f1                	mov    %esi,%ecx
 141:	84 c9                	test   %cl,%cl
 143:	74 5b                	je     1a0 <matchhere+0x90>
 145:	38 cb                	cmp    %cl,%bl
 147:	74 05                	je     14e <matchhere+0x3e>
 149:	80 fb 2e             	cmp    $0x2e,%bl
 14c:	75 52                	jne    1a0 <matchhere+0x90>
    return matchhere(re+1, text+1);
 14e:	83 c7 01             	add    $0x1,%edi
 151:	83 c0 01             	add    $0x1,%eax
  if(re[0] == '\0')
 154:	84 d2                	test   %dl,%dl
 156:	74 31                	je     189 <matchhere+0x79>
  if(re[1] == '*')
 158:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
 15c:	80 fb 2a             	cmp    $0x2a,%bl
 15f:	74 4c                	je     1ad <matchhere+0x9d>
  if(re[0] == '$' && re[1] == '\0')
 161:	80 fa 24             	cmp    $0x24,%dl
 164:	75 04                	jne    16a <matchhere+0x5a>
 166:	84 db                	test   %bl,%bl
 168:	74 5c                	je     1c6 <matchhere+0xb6>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 16a:	0f b6 37             	movzbl (%edi),%esi
 16d:	89 f1                	mov    %esi,%ecx
 16f:	84 c9                	test   %cl,%cl
 171:	74 2d                	je     1a0 <matchhere+0x90>
 173:	80 fa 2e             	cmp    $0x2e,%dl
 176:	74 04                	je     17c <matchhere+0x6c>
 178:	38 d1                	cmp    %dl,%cl
 17a:	75 24                	jne    1a0 <matchhere+0x90>
 17c:	0f be d3             	movsbl %bl,%edx
    return matchhere(re+1, text+1);
 17f:	83 c7 01             	add    $0x1,%edi
 182:	83 c0 01             	add    $0x1,%eax
  if(re[0] == '\0')
 185:	84 d2                	test   %dl,%dl
 187:	75 cf                	jne    158 <matchhere+0x48>
    return 1;
 189:	b8 01 00 00 00       	mov    $0x1,%eax
}
 18e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 191:	5b                   	pop    %ebx
 192:	5e                   	pop    %esi
 193:	5f                   	pop    %edi
 194:	5d                   	pop    %ebp
 195:	c3                   	ret    
 196:	8d 76 00             	lea    0x0(%esi),%esi
 199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 1a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
 1a3:	31 c0                	xor    %eax,%eax
}
 1a5:	5b                   	pop    %ebx
 1a6:	5e                   	pop    %esi
 1a7:	5f                   	pop    %edi
 1a8:	5d                   	pop    %ebp
 1a9:	c3                   	ret    
  if(re[1] == '*')
 1aa:	0f be d3             	movsbl %bl,%edx
    return matchstar(re[0], re+2, text);
 1ad:	83 ec 04             	sub    $0x4,%esp
 1b0:	83 c0 02             	add    $0x2,%eax
 1b3:	57                   	push   %edi
 1b4:	50                   	push   %eax
 1b5:	52                   	push   %edx
 1b6:	e8 f5 fe ff ff       	call   b0 <matchstar>
 1bb:	83 c4 10             	add    $0x10,%esp
}
 1be:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1c1:	5b                   	pop    %ebx
 1c2:	5e                   	pop    %esi
 1c3:	5f                   	pop    %edi
 1c4:	5d                   	pop    %ebp
 1c5:	c3                   	ret    
    return *text == '\0';
 1c6:	31 c0                	xor    %eax,%eax
 1c8:	80 3f 00             	cmpb   $0x0,(%edi)
 1cb:	0f 94 c0             	sete   %al
 1ce:	eb be                	jmp    18e <matchhere+0x7e>

000001d0 <match>:
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	56                   	push   %esi
 1d4:	53                   	push   %ebx
 1d5:	8b 75 08             	mov    0x8(%ebp),%esi
 1d8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '^')
 1db:	80 3e 5e             	cmpb   $0x5e,(%esi)
 1de:	75 11                	jne    1f1 <match+0x21>
 1e0:	eb 2c                	jmp    20e <match+0x3e>
 1e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }while(*text++ != '\0');
 1e8:	83 c3 01             	add    $0x1,%ebx
 1eb:	80 7b ff 00          	cmpb   $0x0,-0x1(%ebx)
 1ef:	74 16                	je     207 <match+0x37>
    if(matchhere(re, text))
 1f1:	83 ec 08             	sub    $0x8,%esp
 1f4:	53                   	push   %ebx
 1f5:	56                   	push   %esi
 1f6:	e8 15 ff ff ff       	call   110 <matchhere>
 1fb:	83 c4 10             	add    $0x10,%esp
 1fe:	85 c0                	test   %eax,%eax
 200:	74 e6                	je     1e8 <match+0x18>
      return 1;
 202:	b8 01 00 00 00       	mov    $0x1,%eax
}
 207:	8d 65 f8             	lea    -0x8(%ebp),%esp
 20a:	5b                   	pop    %ebx
 20b:	5e                   	pop    %esi
 20c:	5d                   	pop    %ebp
 20d:	c3                   	ret    
    return matchhere(re+1, text);
 20e:	83 c6 01             	add    $0x1,%esi
 211:	89 75 08             	mov    %esi,0x8(%ebp)
}
 214:	8d 65 f8             	lea    -0x8(%ebp),%esp
 217:	5b                   	pop    %ebx
 218:	5e                   	pop    %esi
 219:	5d                   	pop    %ebp
    return matchhere(re+1, text);
 21a:	e9 f1 fe ff ff       	jmp    110 <matchhere>
 21f:	90                   	nop

00000220 <grep>:
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	57                   	push   %edi
 224:	56                   	push   %esi
 225:	53                   	push   %ebx
 226:	83 ec 1c             	sub    $0x1c,%esp
 229:	8b 75 08             	mov    0x8(%ebp),%esi
  m = 0;
 22c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 233:	90                   	nop
 234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 238:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 23b:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 240:	83 ec 04             	sub    $0x4,%esp
 243:	29 c8                	sub    %ecx,%eax
 245:	50                   	push   %eax
 246:	8d 81 a0 0e 00 00    	lea    0xea0(%ecx),%eax
 24c:	50                   	push   %eax
 24d:	ff 75 0c             	pushl  0xc(%ebp)
 250:	e8 25 03 00 00       	call   57a <read>
 255:	83 c4 10             	add    $0x10,%esp
 258:	85 c0                	test   %eax,%eax
 25a:	0f 8e ac 00 00 00    	jle    30c <grep+0xec>
    m += n;
 260:	01 45 e4             	add    %eax,-0x1c(%ebp)
    p = buf;
 263:	bb a0 0e 00 00       	mov    $0xea0,%ebx
    m += n;
 268:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    buf[m] = '\0';
 26b:	c6 82 a0 0e 00 00 00 	movb   $0x0,0xea0(%edx)
 272:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while((q = strchr(p, '\n')) != 0){
 278:	83 ec 08             	sub    $0x8,%esp
 27b:	6a 0a                	push   $0xa
 27d:	53                   	push   %ebx
 27e:	e8 6d 01 00 00       	call   3f0 <strchr>
 283:	83 c4 10             	add    $0x10,%esp
 286:	85 c0                	test   %eax,%eax
 288:	89 c7                	mov    %eax,%edi
 28a:	74 3c                	je     2c8 <grep+0xa8>
      if(match(pattern, p)){
 28c:	83 ec 08             	sub    $0x8,%esp
      *q = 0;
 28f:	c6 07 00             	movb   $0x0,(%edi)
      if(match(pattern, p)){
 292:	53                   	push   %ebx
 293:	56                   	push   %esi
 294:	e8 37 ff ff ff       	call   1d0 <match>
 299:	83 c4 10             	add    $0x10,%esp
 29c:	85 c0                	test   %eax,%eax
 29e:	75 08                	jne    2a8 <grep+0x88>
 2a0:	8d 5f 01             	lea    0x1(%edi),%ebx
 2a3:	eb d3                	jmp    278 <grep+0x58>
 2a5:	8d 76 00             	lea    0x0(%esi),%esi
        *q = '\n';
 2a8:	c6 07 0a             	movb   $0xa,(%edi)
        write(1, p, q+1 - p);
 2ab:	83 c7 01             	add    $0x1,%edi
 2ae:	83 ec 04             	sub    $0x4,%esp
 2b1:	89 f8                	mov    %edi,%eax
 2b3:	29 d8                	sub    %ebx,%eax
 2b5:	50                   	push   %eax
 2b6:	53                   	push   %ebx
 2b7:	89 fb                	mov    %edi,%ebx
 2b9:	6a 01                	push   $0x1
 2bb:	e8 c2 02 00 00       	call   582 <write>
 2c0:	83 c4 10             	add    $0x10,%esp
 2c3:	eb b3                	jmp    278 <grep+0x58>
 2c5:	8d 76 00             	lea    0x0(%esi),%esi
    if(p == buf)
 2c8:	81 fb a0 0e 00 00    	cmp    $0xea0,%ebx
 2ce:	74 30                	je     300 <grep+0xe0>
    if(m > 0){
 2d0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 2d3:	85 c0                	test   %eax,%eax
 2d5:	0f 8e 5d ff ff ff    	jle    238 <grep+0x18>
      m -= p - buf;
 2db:	89 d8                	mov    %ebx,%eax
      memmove(buf, p, m);
 2dd:	83 ec 04             	sub    $0x4,%esp
      m -= p - buf;
 2e0:	2d a0 0e 00 00       	sub    $0xea0,%eax
 2e5:	29 45 e4             	sub    %eax,-0x1c(%ebp)
 2e8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
      memmove(buf, p, m);
 2eb:	51                   	push   %ecx
 2ec:	53                   	push   %ebx
 2ed:	68 a0 0e 00 00       	push   $0xea0
 2f2:	e8 39 02 00 00       	call   530 <memmove>
 2f7:	83 c4 10             	add    $0x10,%esp
 2fa:	e9 39 ff ff ff       	jmp    238 <grep+0x18>
 2ff:	90                   	nop
      m = 0;
 300:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 307:	e9 2c ff ff ff       	jmp    238 <grep+0x18>
}
 30c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 30f:	5b                   	pop    %ebx
 310:	5e                   	pop    %esi
 311:	5f                   	pop    %edi
 312:	5d                   	pop    %ebp
 313:	c3                   	ret    
 314:	66 90                	xchg   %ax,%ax
 316:	66 90                	xchg   %ax,%ax
 318:	66 90                	xchg   %ax,%ax
 31a:	66 90                	xchg   %ax,%ax
 31c:	66 90                	xchg   %ax,%ax
 31e:	66 90                	xchg   %ax,%ax

00000320 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	53                   	push   %ebx
 324:	8b 45 08             	mov    0x8(%ebp),%eax
 327:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 32a:	89 c2                	mov    %eax,%edx
 32c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 330:	83 c1 01             	add    $0x1,%ecx
 333:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 337:	83 c2 01             	add    $0x1,%edx
 33a:	84 db                	test   %bl,%bl
 33c:	88 5a ff             	mov    %bl,-0x1(%edx)
 33f:	75 ef                	jne    330 <strcpy+0x10>
    ;
  return os;
}
 341:	5b                   	pop    %ebx
 342:	5d                   	pop    %ebp
 343:	c3                   	ret    
 344:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 34a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000350 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	56                   	push   %esi
 354:	53                   	push   %ebx
 355:	8b 55 08             	mov    0x8(%ebp),%edx
 358:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 35b:	0f b6 02             	movzbl (%edx),%eax
 35e:	0f b6 19             	movzbl (%ecx),%ebx
 361:	84 c0                	test   %al,%al
 363:	75 1e                	jne    383 <strcmp+0x33>
 365:	eb 29                	jmp    390 <strcmp+0x40>
 367:	89 f6                	mov    %esi,%esi
 369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 370:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 373:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 376:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
 379:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 37d:	84 c0                	test   %al,%al
 37f:	74 0f                	je     390 <strcmp+0x40>
 381:	89 f1                	mov    %esi,%ecx
 383:	38 d8                	cmp    %bl,%al
 385:	74 e9                	je     370 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 387:	29 d8                	sub    %ebx,%eax
}
 389:	5b                   	pop    %ebx
 38a:	5e                   	pop    %esi
 38b:	5d                   	pop    %ebp
 38c:	c3                   	ret    
 38d:	8d 76 00             	lea    0x0(%esi),%esi
  while(*p && *p == *q)
 390:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 392:	29 d8                	sub    %ebx,%eax
}
 394:	5b                   	pop    %ebx
 395:	5e                   	pop    %esi
 396:	5d                   	pop    %ebp
 397:	c3                   	ret    
 398:	90                   	nop
 399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003a0 <strlen>:

uint
strlen(char *s)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 3a6:	80 39 00             	cmpb   $0x0,(%ecx)
 3a9:	74 12                	je     3bd <strlen+0x1d>
 3ab:	31 d2                	xor    %edx,%edx
 3ad:	8d 76 00             	lea    0x0(%esi),%esi
 3b0:	83 c2 01             	add    $0x1,%edx
 3b3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 3b7:	89 d0                	mov    %edx,%eax
 3b9:	75 f5                	jne    3b0 <strlen+0x10>
    ;
  return n;
}
 3bb:	5d                   	pop    %ebp
 3bc:	c3                   	ret    
  for(n = 0; s[n]; n++)
 3bd:	31 c0                	xor    %eax,%eax
}
 3bf:	5d                   	pop    %ebp
 3c0:	c3                   	ret    
 3c1:	eb 0d                	jmp    3d0 <memset>
 3c3:	90                   	nop
 3c4:	90                   	nop
 3c5:	90                   	nop
 3c6:	90                   	nop
 3c7:	90                   	nop
 3c8:	90                   	nop
 3c9:	90                   	nop
 3ca:	90                   	nop
 3cb:	90                   	nop
 3cc:	90                   	nop
 3cd:	90                   	nop
 3ce:	90                   	nop
 3cf:	90                   	nop

000003d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	57                   	push   %edi
 3d4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 3d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3da:	8b 45 0c             	mov    0xc(%ebp),%eax
 3dd:	89 d7                	mov    %edx,%edi
 3df:	fc                   	cld    
 3e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3e2:	89 d0                	mov    %edx,%eax
 3e4:	5f                   	pop    %edi
 3e5:	5d                   	pop    %ebp
 3e6:	c3                   	ret    
 3e7:	89 f6                	mov    %esi,%esi
 3e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003f0 <strchr>:

char*
strchr(const char *s, char c)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	53                   	push   %ebx
 3f4:	8b 45 08             	mov    0x8(%ebp),%eax
 3f7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 3fa:	0f b6 10             	movzbl (%eax),%edx
 3fd:	84 d2                	test   %dl,%dl
 3ff:	74 1d                	je     41e <strchr+0x2e>
    if(*s == c)
 401:	38 d3                	cmp    %dl,%bl
 403:	89 d9                	mov    %ebx,%ecx
 405:	75 0d                	jne    414 <strchr+0x24>
 407:	eb 17                	jmp    420 <strchr+0x30>
 409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 410:	38 ca                	cmp    %cl,%dl
 412:	74 0c                	je     420 <strchr+0x30>
  for(; *s; s++)
 414:	83 c0 01             	add    $0x1,%eax
 417:	0f b6 10             	movzbl (%eax),%edx
 41a:	84 d2                	test   %dl,%dl
 41c:	75 f2                	jne    410 <strchr+0x20>
      return (char*)s;
  return 0;
 41e:	31 c0                	xor    %eax,%eax
}
 420:	5b                   	pop    %ebx
 421:	5d                   	pop    %ebp
 422:	c3                   	ret    
 423:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000430 <gets>:

char*
gets(char *buf, int max)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	57                   	push   %edi
 434:	56                   	push   %esi
 435:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 436:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 438:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 43b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 43e:	eb 29                	jmp    469 <gets+0x39>
    cc = read(0, &c, 1);
 440:	83 ec 04             	sub    $0x4,%esp
 443:	6a 01                	push   $0x1
 445:	57                   	push   %edi
 446:	6a 00                	push   $0x0
 448:	e8 2d 01 00 00       	call   57a <read>
    if(cc < 1)
 44d:	83 c4 10             	add    $0x10,%esp
 450:	85 c0                	test   %eax,%eax
 452:	7e 1d                	jle    471 <gets+0x41>
      break;
    buf[i++] = c;
 454:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 458:	8b 55 08             	mov    0x8(%ebp),%edx
 45b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 45d:	3c 0a                	cmp    $0xa,%al
    buf[i++] = c;
 45f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 463:	74 1b                	je     480 <gets+0x50>
 465:	3c 0d                	cmp    $0xd,%al
 467:	74 17                	je     480 <gets+0x50>
  for(i=0; i+1 < max; ){
 469:	8d 5e 01             	lea    0x1(%esi),%ebx
 46c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 46f:	7c cf                	jl     440 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 471:	8b 45 08             	mov    0x8(%ebp),%eax
 474:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 478:	8d 65 f4             	lea    -0xc(%ebp),%esp
 47b:	5b                   	pop    %ebx
 47c:	5e                   	pop    %esi
 47d:	5f                   	pop    %edi
 47e:	5d                   	pop    %ebp
 47f:	c3                   	ret    
  buf[i] = '\0';
 480:	8b 45 08             	mov    0x8(%ebp),%eax
  for(i=0; i+1 < max; ){
 483:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 485:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 489:	8d 65 f4             	lea    -0xc(%ebp),%esp
 48c:	5b                   	pop    %ebx
 48d:	5e                   	pop    %esi
 48e:	5f                   	pop    %edi
 48f:	5d                   	pop    %ebp
 490:	c3                   	ret    
 491:	eb 0d                	jmp    4a0 <stat>
 493:	90                   	nop
 494:	90                   	nop
 495:	90                   	nop
 496:	90                   	nop
 497:	90                   	nop
 498:	90                   	nop
 499:	90                   	nop
 49a:	90                   	nop
 49b:	90                   	nop
 49c:	90                   	nop
 49d:	90                   	nop
 49e:	90                   	nop
 49f:	90                   	nop

000004a0 <stat>:

int
stat(char *n, struct stat *st)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	56                   	push   %esi
 4a4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4a5:	83 ec 08             	sub    $0x8,%esp
 4a8:	6a 00                	push   $0x0
 4aa:	ff 75 08             	pushl  0x8(%ebp)
 4ad:	e8 f0 00 00 00       	call   5a2 <open>
  if(fd < 0)
 4b2:	83 c4 10             	add    $0x10,%esp
 4b5:	85 c0                	test   %eax,%eax
 4b7:	78 27                	js     4e0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 4b9:	83 ec 08             	sub    $0x8,%esp
 4bc:	ff 75 0c             	pushl  0xc(%ebp)
 4bf:	89 c3                	mov    %eax,%ebx
 4c1:	50                   	push   %eax
 4c2:	e8 f3 00 00 00       	call   5ba <fstat>
  close(fd);
 4c7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 4ca:	89 c6                	mov    %eax,%esi
  close(fd);
 4cc:	e8 b9 00 00 00       	call   58a <close>
  return r;
 4d1:	83 c4 10             	add    $0x10,%esp
}
 4d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 4d7:	89 f0                	mov    %esi,%eax
 4d9:	5b                   	pop    %ebx
 4da:	5e                   	pop    %esi
 4db:	5d                   	pop    %ebp
 4dc:	c3                   	ret    
 4dd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 4e0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 4e5:	eb ed                	jmp    4d4 <stat+0x34>
 4e7:	89 f6                	mov    %esi,%esi
 4e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004f0 <atoi>:

int
atoi(const char *s)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	53                   	push   %ebx
 4f4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4f7:	0f be 11             	movsbl (%ecx),%edx
 4fa:	8d 42 d0             	lea    -0x30(%edx),%eax
 4fd:	3c 09                	cmp    $0x9,%al
 4ff:	b8 00 00 00 00       	mov    $0x0,%eax
 504:	77 1f                	ja     525 <atoi+0x35>
 506:	8d 76 00             	lea    0x0(%esi),%esi
 509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 510:	8d 04 80             	lea    (%eax,%eax,4),%eax
 513:	83 c1 01             	add    $0x1,%ecx
 516:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 51a:	0f be 11             	movsbl (%ecx),%edx
 51d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 520:	80 fb 09             	cmp    $0x9,%bl
 523:	76 eb                	jbe    510 <atoi+0x20>
  return n;
}
 525:	5b                   	pop    %ebx
 526:	5d                   	pop    %ebp
 527:	c3                   	ret    
 528:	90                   	nop
 529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000530 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	56                   	push   %esi
 534:	53                   	push   %ebx
 535:	8b 5d 10             	mov    0x10(%ebp),%ebx
 538:	8b 45 08             	mov    0x8(%ebp),%eax
 53b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 53e:	85 db                	test   %ebx,%ebx
 540:	7e 14                	jle    556 <memmove+0x26>
 542:	31 d2                	xor    %edx,%edx
 544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 548:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 54c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 54f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 552:	39 da                	cmp    %ebx,%edx
 554:	75 f2                	jne    548 <memmove+0x18>
  return vdst;
}
 556:	5b                   	pop    %ebx
 557:	5e                   	pop    %esi
 558:	5d                   	pop    %ebp
 559:	c3                   	ret    

0000055a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 55a:	b8 01 00 00 00       	mov    $0x1,%eax
 55f:	cd 40                	int    $0x40
 561:	c3                   	ret    

00000562 <exit>:
SYSCALL(exit)
 562:	b8 02 00 00 00       	mov    $0x2,%eax
 567:	cd 40                	int    $0x40
 569:	c3                   	ret    

0000056a <wait>:
SYSCALL(wait)
 56a:	b8 03 00 00 00       	mov    $0x3,%eax
 56f:	cd 40                	int    $0x40
 571:	c3                   	ret    

00000572 <pipe>:
SYSCALL(pipe)
 572:	b8 04 00 00 00       	mov    $0x4,%eax
 577:	cd 40                	int    $0x40
 579:	c3                   	ret    

0000057a <read>:
SYSCALL(read)
 57a:	b8 05 00 00 00       	mov    $0x5,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <write>:
SYSCALL(write)
 582:	b8 10 00 00 00       	mov    $0x10,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    

0000058a <close>:
SYSCALL(close)
 58a:	b8 15 00 00 00       	mov    $0x15,%eax
 58f:	cd 40                	int    $0x40
 591:	c3                   	ret    

00000592 <kill>:
SYSCALL(kill)
 592:	b8 06 00 00 00       	mov    $0x6,%eax
 597:	cd 40                	int    $0x40
 599:	c3                   	ret    

0000059a <exec>:
SYSCALL(exec)
 59a:	b8 07 00 00 00       	mov    $0x7,%eax
 59f:	cd 40                	int    $0x40
 5a1:	c3                   	ret    

000005a2 <open>:
SYSCALL(open)
 5a2:	b8 0f 00 00 00       	mov    $0xf,%eax
 5a7:	cd 40                	int    $0x40
 5a9:	c3                   	ret    

000005aa <mknod>:
SYSCALL(mknod)
 5aa:	b8 11 00 00 00       	mov    $0x11,%eax
 5af:	cd 40                	int    $0x40
 5b1:	c3                   	ret    

000005b2 <unlink>:
SYSCALL(unlink)
 5b2:	b8 12 00 00 00       	mov    $0x12,%eax
 5b7:	cd 40                	int    $0x40
 5b9:	c3                   	ret    

000005ba <fstat>:
SYSCALL(fstat)
 5ba:	b8 08 00 00 00       	mov    $0x8,%eax
 5bf:	cd 40                	int    $0x40
 5c1:	c3                   	ret    

000005c2 <link>:
SYSCALL(link)
 5c2:	b8 13 00 00 00       	mov    $0x13,%eax
 5c7:	cd 40                	int    $0x40
 5c9:	c3                   	ret    

000005ca <mkdir>:
SYSCALL(mkdir)
 5ca:	b8 14 00 00 00       	mov    $0x14,%eax
 5cf:	cd 40                	int    $0x40
 5d1:	c3                   	ret    

000005d2 <chdir>:
SYSCALL(chdir)
 5d2:	b8 09 00 00 00       	mov    $0x9,%eax
 5d7:	cd 40                	int    $0x40
 5d9:	c3                   	ret    

000005da <dup>:
SYSCALL(dup)
 5da:	b8 0a 00 00 00       	mov    $0xa,%eax
 5df:	cd 40                	int    $0x40
 5e1:	c3                   	ret    

000005e2 <getpid>:
SYSCALL(getpid)
 5e2:	b8 0b 00 00 00       	mov    $0xb,%eax
 5e7:	cd 40                	int    $0x40
 5e9:	c3                   	ret    

000005ea <sbrk>:
SYSCALL(sbrk)
 5ea:	b8 0c 00 00 00       	mov    $0xc,%eax
 5ef:	cd 40                	int    $0x40
 5f1:	c3                   	ret    

000005f2 <sleep>:
SYSCALL(sleep)
 5f2:	b8 0d 00 00 00       	mov    $0xd,%eax
 5f7:	cd 40                	int    $0x40
 5f9:	c3                   	ret    

000005fa <uptime>:
SYSCALL(uptime)
 5fa:	b8 0e 00 00 00       	mov    $0xe,%eax
 5ff:	cd 40                	int    $0x40
 601:	c3                   	ret    

00000602 <dup2>:
SYSCALL(dup2)
 602:	b8 16 00 00 00       	mov    $0x16,%eax
 607:	cd 40                	int    $0x40
 609:	c3                   	ret    

0000060a <getcwd>:
SYSCALL(getcwd)
 60a:	b8 17 00 00 00       	mov    $0x17,%eax
 60f:	cd 40                	int    $0x40
 611:	c3                   	ret    

00000612 <mem_jared>:
SYSCALL(mem_jared)
 612:	b8 18 00 00 00       	mov    $0x18,%eax
 617:	cd 40                	int    $0x40
 619:	c3                   	ret    
 61a:	66 90                	xchg   %ax,%ax
 61c:	66 90                	xchg   %ax,%ax
 61e:	66 90                	xchg   %ax,%ax

00000620 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	57                   	push   %edi
 624:	56                   	push   %esi
 625:	53                   	push   %ebx
 626:	89 c6                	mov    %eax,%esi
 628:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 62b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 62e:	85 db                	test   %ebx,%ebx
 630:	74 7e                	je     6b0 <printint+0x90>
 632:	89 d0                	mov    %edx,%eax
 634:	c1 e8 1f             	shr    $0x1f,%eax
 637:	84 c0                	test   %al,%al
 639:	74 75                	je     6b0 <printint+0x90>
    neg = 1;
    x = -xx;
 63b:	89 d0                	mov    %edx,%eax
    neg = 1;
 63d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 644:	f7 d8                	neg    %eax
 646:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 649:	31 ff                	xor    %edi,%edi
 64b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 64e:	89 ce                	mov    %ecx,%esi
 650:	eb 08                	jmp    65a <printint+0x3a>
 652:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 658:	89 cf                	mov    %ecx,%edi
 65a:	31 d2                	xor    %edx,%edx
 65c:	8d 4f 01             	lea    0x1(%edi),%ecx
 65f:	f7 f6                	div    %esi
 661:	0f b6 92 90 0a 00 00 	movzbl 0xa90(%edx),%edx
  }while((x /= base) != 0);
 668:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 66a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 66d:	75 e9                	jne    658 <printint+0x38>
  if(neg)
 66f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 672:	8b 75 c0             	mov    -0x40(%ebp),%esi
 675:	85 c0                	test   %eax,%eax
 677:	74 08                	je     681 <printint+0x61>
    buf[i++] = '-';
 679:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 67e:	8d 4f 02             	lea    0x2(%edi),%ecx

  while(--i >= 0)
 681:	8d 79 ff             	lea    -0x1(%ecx),%edi
 684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 688:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
  write(fd, &c, 1);
 68d:	83 ec 04             	sub    $0x4,%esp
  while(--i >= 0)
 690:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 693:	6a 01                	push   $0x1
 695:	53                   	push   %ebx
 696:	56                   	push   %esi
 697:	88 45 d7             	mov    %al,-0x29(%ebp)
 69a:	e8 e3 fe ff ff       	call   582 <write>
  while(--i >= 0)
 69f:	83 c4 10             	add    $0x10,%esp
 6a2:	83 ff ff             	cmp    $0xffffffff,%edi
 6a5:	75 e1                	jne    688 <printint+0x68>
    putc(fd, buf[i]);
}
 6a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6aa:	5b                   	pop    %ebx
 6ab:	5e                   	pop    %esi
 6ac:	5f                   	pop    %edi
 6ad:	5d                   	pop    %ebp
 6ae:	c3                   	ret    
 6af:	90                   	nop
    x = xx;
 6b0:	89 d0                	mov    %edx,%eax
  neg = 0;
 6b2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 6b9:	eb 8b                	jmp    646 <printint+0x26>
 6bb:	90                   	nop
 6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006c0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	57                   	push   %edi
 6c4:	56                   	push   %esi
 6c5:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6c6:	8d 45 10             	lea    0x10(%ebp),%eax
{
 6c9:	83 ec 2c             	sub    $0x2c,%esp
  for(i = 0; fmt[i]; i++){
 6cc:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 6cf:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 6d2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 6d5:	0f b6 1e             	movzbl (%esi),%ebx
 6d8:	83 c6 01             	add    $0x1,%esi
 6db:	84 db                	test   %bl,%bl
 6dd:	0f 84 b0 00 00 00    	je     793 <printf+0xd3>
 6e3:	31 d2                	xor    %edx,%edx
 6e5:	eb 39                	jmp    720 <printf+0x60>
 6e7:	89 f6                	mov    %esi,%esi
 6e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 6f0:	83 f8 25             	cmp    $0x25,%eax
 6f3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 6f6:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 6fb:	74 18                	je     715 <printf+0x55>
  write(fd, &c, 1);
 6fd:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 700:	83 ec 04             	sub    $0x4,%esp
 703:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 706:	6a 01                	push   $0x1
 708:	50                   	push   %eax
 709:	57                   	push   %edi
 70a:	e8 73 fe ff ff       	call   582 <write>
 70f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 712:	83 c4 10             	add    $0x10,%esp
 715:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 718:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 71c:	84 db                	test   %bl,%bl
 71e:	74 73                	je     793 <printf+0xd3>
    if(state == 0){
 720:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 722:	0f be cb             	movsbl %bl,%ecx
 725:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 728:	74 c6                	je     6f0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 72a:	83 fa 25             	cmp    $0x25,%edx
 72d:	75 e6                	jne    715 <printf+0x55>
      if(c == 'd'){
 72f:	83 f8 64             	cmp    $0x64,%eax
 732:	0f 84 f8 00 00 00    	je     830 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 738:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 73e:	83 f9 70             	cmp    $0x70,%ecx
 741:	74 5d                	je     7a0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 743:	83 f8 73             	cmp    $0x73,%eax
 746:	0f 84 84 00 00 00    	je     7d0 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 74c:	83 f8 63             	cmp    $0x63,%eax
 74f:	0f 84 ea 00 00 00    	je     83f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 755:	83 f8 25             	cmp    $0x25,%eax
 758:	0f 84 c2 00 00 00    	je     820 <printf+0x160>
  write(fd, &c, 1);
 75e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 761:	83 ec 04             	sub    $0x4,%esp
 764:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 768:	6a 01                	push   $0x1
 76a:	50                   	push   %eax
 76b:	57                   	push   %edi
 76c:	e8 11 fe ff ff       	call   582 <write>
 771:	83 c4 0c             	add    $0xc,%esp
 774:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 777:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 77a:	6a 01                	push   $0x1
 77c:	50                   	push   %eax
 77d:	57                   	push   %edi
 77e:	83 c6 01             	add    $0x1,%esi
 781:	e8 fc fd ff ff       	call   582 <write>
  for(i = 0; fmt[i]; i++){
 786:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 78a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 78d:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 78f:	84 db                	test   %bl,%bl
 791:	75 8d                	jne    720 <printf+0x60>
    }
  }
}
 793:	8d 65 f4             	lea    -0xc(%ebp),%esp
 796:	5b                   	pop    %ebx
 797:	5e                   	pop    %esi
 798:	5f                   	pop    %edi
 799:	5d                   	pop    %ebp
 79a:	c3                   	ret    
 79b:	90                   	nop
 79c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 16, 0);
 7a0:	83 ec 0c             	sub    $0xc,%esp
 7a3:	b9 10 00 00 00       	mov    $0x10,%ecx
 7a8:	6a 00                	push   $0x0
 7aa:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 7ad:	89 f8                	mov    %edi,%eax
 7af:	8b 13                	mov    (%ebx),%edx
 7b1:	e8 6a fe ff ff       	call   620 <printint>
        ap++;
 7b6:	89 d8                	mov    %ebx,%eax
 7b8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 7bb:	31 d2                	xor    %edx,%edx
        ap++;
 7bd:	83 c0 04             	add    $0x4,%eax
 7c0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 7c3:	e9 4d ff ff ff       	jmp    715 <printf+0x55>
 7c8:	90                   	nop
 7c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 7d0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 7d3:	8b 18                	mov    (%eax),%ebx
        ap++;
 7d5:	83 c0 04             	add    $0x4,%eax
 7d8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 7db:	85 db                	test   %ebx,%ebx
 7dd:	74 7c                	je     85b <printf+0x19b>
        while(*s != 0){
 7df:	0f b6 03             	movzbl (%ebx),%eax
 7e2:	84 c0                	test   %al,%al
 7e4:	74 29                	je     80f <printf+0x14f>
 7e6:	8d 76 00             	lea    0x0(%esi),%esi
 7e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 7f0:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 7f3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 7f6:	83 ec 04             	sub    $0x4,%esp
 7f9:	6a 01                	push   $0x1
          s++;
 7fb:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 7fe:	50                   	push   %eax
 7ff:	57                   	push   %edi
 800:	e8 7d fd ff ff       	call   582 <write>
        while(*s != 0){
 805:	0f b6 03             	movzbl (%ebx),%eax
 808:	83 c4 10             	add    $0x10,%esp
 80b:	84 c0                	test   %al,%al
 80d:	75 e1                	jne    7f0 <printf+0x130>
      state = 0;
 80f:	31 d2                	xor    %edx,%edx
 811:	e9 ff fe ff ff       	jmp    715 <printf+0x55>
 816:	8d 76 00             	lea    0x0(%esi),%esi
 819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  write(fd, &c, 1);
 820:	83 ec 04             	sub    $0x4,%esp
 823:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 826:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 829:	6a 01                	push   $0x1
 82b:	e9 4c ff ff ff       	jmp    77c <printf+0xbc>
        printint(fd, *ap, 10, 1);
 830:	83 ec 0c             	sub    $0xc,%esp
 833:	b9 0a 00 00 00       	mov    $0xa,%ecx
 838:	6a 01                	push   $0x1
 83a:	e9 6b ff ff ff       	jmp    7aa <printf+0xea>
        putc(fd, *ap);
 83f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 842:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 845:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 847:	6a 01                	push   $0x1
        putc(fd, *ap);
 849:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 84c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 84f:	50                   	push   %eax
 850:	57                   	push   %edi
 851:	e8 2c fd ff ff       	call   582 <write>
 856:	e9 5b ff ff ff       	jmp    7b6 <printf+0xf6>
        while(*s != 0){
 85b:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 860:	bb 86 0a 00 00       	mov    $0xa86,%ebx
 865:	eb 89                	jmp    7f0 <printf+0x130>
 867:	66 90                	xchg   %ax,%ax
 869:	66 90                	xchg   %ax,%ax
 86b:	66 90                	xchg   %ax,%ax
 86d:	66 90                	xchg   %ax,%ax
 86f:	90                   	nop

00000870 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 870:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 871:	a1 80 0e 00 00       	mov    0xe80,%eax
{
 876:	89 e5                	mov    %esp,%ebp
 878:	57                   	push   %edi
 879:	56                   	push   %esi
 87a:	53                   	push   %ebx
 87b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 87e:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 880:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 883:	39 c8                	cmp    %ecx,%eax
 885:	73 19                	jae    8a0 <free+0x30>
 887:	89 f6                	mov    %esi,%esi
 889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 890:	39 d1                	cmp    %edx,%ecx
 892:	72 1c                	jb     8b0 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 894:	39 d0                	cmp    %edx,%eax
 896:	73 18                	jae    8b0 <free+0x40>
{
 898:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 89a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 89c:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 89e:	72 f0                	jb     890 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8a0:	39 d0                	cmp    %edx,%eax
 8a2:	72 f4                	jb     898 <free+0x28>
 8a4:	39 d1                	cmp    %edx,%ecx
 8a6:	73 f0                	jae    898 <free+0x28>
 8a8:	90                   	nop
 8a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 8b0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 8b3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 8b6:	39 fa                	cmp    %edi,%edx
 8b8:	74 19                	je     8d3 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 8ba:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 8bd:	8b 50 04             	mov    0x4(%eax),%edx
 8c0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 8c3:	39 f1                	cmp    %esi,%ecx
 8c5:	74 23                	je     8ea <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 8c7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 8c9:	a3 80 0e 00 00       	mov    %eax,0xe80
}
 8ce:	5b                   	pop    %ebx
 8cf:	5e                   	pop    %esi
 8d0:	5f                   	pop    %edi
 8d1:	5d                   	pop    %ebp
 8d2:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 8d3:	03 72 04             	add    0x4(%edx),%esi
 8d6:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 8d9:	8b 10                	mov    (%eax),%edx
 8db:	8b 12                	mov    (%edx),%edx
 8dd:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 8e0:	8b 50 04             	mov    0x4(%eax),%edx
 8e3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 8e6:	39 f1                	cmp    %esi,%ecx
 8e8:	75 dd                	jne    8c7 <free+0x57>
    p->s.size += bp->s.size;
 8ea:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 8ed:	a3 80 0e 00 00       	mov    %eax,0xe80
    p->s.size += bp->s.size;
 8f2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 8f5:	8b 53 f8             	mov    -0x8(%ebx),%edx
 8f8:	89 10                	mov    %edx,(%eax)
}
 8fa:	5b                   	pop    %ebx
 8fb:	5e                   	pop    %esi
 8fc:	5f                   	pop    %edi
 8fd:	5d                   	pop    %ebp
 8fe:	c3                   	ret    
 8ff:	90                   	nop

00000900 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 900:	55                   	push   %ebp
 901:	89 e5                	mov    %esp,%ebp
 903:	57                   	push   %edi
 904:	56                   	push   %esi
 905:	53                   	push   %ebx
 906:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 909:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 90c:	8b 15 80 0e 00 00    	mov    0xe80,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 912:	8d 78 07             	lea    0x7(%eax),%edi
 915:	c1 ef 03             	shr    $0x3,%edi
 918:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 91b:	85 d2                	test   %edx,%edx
 91d:	0f 84 93 00 00 00    	je     9b6 <malloc+0xb6>
 923:	8b 02                	mov    (%edx),%eax
 925:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 928:	39 cf                	cmp    %ecx,%edi
 92a:	76 64                	jbe    990 <malloc+0x90>
 92c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 932:	bb 00 10 00 00       	mov    $0x1000,%ebx
 937:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 93a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 941:	eb 0e                	jmp    951 <malloc+0x51>
 943:	90                   	nop
 944:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 948:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 94a:	8b 48 04             	mov    0x4(%eax),%ecx
 94d:	39 cf                	cmp    %ecx,%edi
 94f:	76 3f                	jbe    990 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 951:	39 05 80 0e 00 00    	cmp    %eax,0xe80
 957:	89 c2                	mov    %eax,%edx
 959:	75 ed                	jne    948 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 95b:	83 ec 0c             	sub    $0xc,%esp
 95e:	56                   	push   %esi
 95f:	e8 86 fc ff ff       	call   5ea <sbrk>
  if(p == (char*)-1)
 964:	83 c4 10             	add    $0x10,%esp
 967:	83 f8 ff             	cmp    $0xffffffff,%eax
 96a:	74 1c                	je     988 <malloc+0x88>
  hp->s.size = nu;
 96c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 96f:	83 ec 0c             	sub    $0xc,%esp
 972:	83 c0 08             	add    $0x8,%eax
 975:	50                   	push   %eax
 976:	e8 f5 fe ff ff       	call   870 <free>
  return freep;
 97b:	8b 15 80 0e 00 00    	mov    0xe80,%edx
      if((p = morecore(nunits)) == 0)
 981:	83 c4 10             	add    $0x10,%esp
 984:	85 d2                	test   %edx,%edx
 986:	75 c0                	jne    948 <malloc+0x48>
        return 0;
 988:	31 c0                	xor    %eax,%eax
 98a:	eb 1c                	jmp    9a8 <malloc+0xa8>
 98c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 990:	39 cf                	cmp    %ecx,%edi
 992:	74 1c                	je     9b0 <malloc+0xb0>
        p->s.size -= nunits;
 994:	29 f9                	sub    %edi,%ecx
 996:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 999:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 99c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 99f:	89 15 80 0e 00 00    	mov    %edx,0xe80
      return (void*)(p + 1);
 9a5:	83 c0 08             	add    $0x8,%eax
  }
}
 9a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9ab:	5b                   	pop    %ebx
 9ac:	5e                   	pop    %esi
 9ad:	5f                   	pop    %edi
 9ae:	5d                   	pop    %ebp
 9af:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 9b0:	8b 08                	mov    (%eax),%ecx
 9b2:	89 0a                	mov    %ecx,(%edx)
 9b4:	eb e9                	jmp    99f <malloc+0x9f>
    base.s.ptr = freep = prevp = &base;
 9b6:	c7 05 80 0e 00 00 84 	movl   $0xe84,0xe80
 9bd:	0e 00 00 
 9c0:	c7 05 84 0e 00 00 84 	movl   $0xe84,0xe84
 9c7:	0e 00 00 
    base.s.size = 0;
 9ca:	b8 84 0e 00 00       	mov    $0xe84,%eax
 9cf:	c7 05 88 0e 00 00 00 	movl   $0x0,0xe88
 9d6:	00 00 00 
 9d9:	e9 4e ff ff ff       	jmp    92c <malloc+0x2c>
 9de:	66 90                	xchg   %ax,%ax

000009e0 <calloc>:

void*
calloc(uint nmemb, uint sz)
{
 9e0:	55                   	push   %ebp
 9e1:	89 e5                	mov    %esp,%ebp
 9e3:	56                   	push   %esi
 9e4:	53                   	push   %ebx
  uint full_sz = 0;
  if (__builtin_mul_overflow(nmemb, sz, &full_sz))
 9e5:	8b 45 08             	mov    0x8(%ebp),%eax
 9e8:	f7 65 0c             	mull   0xc(%ebp)
 9eb:	70 25                	jo     a12 <calloc+0x32>
    return NULL;
  void *region = malloc(full_sz);
 9ed:	83 ec 0c             	sub    $0xc,%esp
 9f0:	89 c3                	mov    %eax,%ebx
 9f2:	50                   	push   %eax
 9f3:	e8 08 ff ff ff       	call   900 <malloc>
  memset(region, 0, full_sz);
 9f8:	83 c4 0c             	add    $0xc,%esp
  void *region = malloc(full_sz);
 9fb:	89 c6                	mov    %eax,%esi
  memset(region, 0, full_sz);
 9fd:	53                   	push   %ebx
 9fe:	6a 00                	push   $0x0
 a00:	50                   	push   %eax
 a01:	e8 ca f9 ff ff       	call   3d0 <memset>
  return region;
 a06:	83 c4 10             	add    $0x10,%esp
}
 a09:	8d 65 f8             	lea    -0x8(%ebp),%esp
 a0c:	89 f0                	mov    %esi,%eax
 a0e:	5b                   	pop    %ebx
 a0f:	5e                   	pop    %esi
 a10:	5d                   	pop    %ebp
 a11:	c3                   	ret    
    return NULL;
 a12:	31 f6                	xor    %esi,%esi
 a14:	eb f3                	jmp    a09 <calloc+0x29>
 a16:	8d 76 00             	lea    0x0(%esi),%esi
 a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a20 <strdup>:

char*
strdup(char *s)
{
 a20:	55                   	push   %ebp
 a21:	89 e5                	mov    %esp,%ebp
 a23:	56                   	push   %esi
 a24:	53                   	push   %ebx
 a25:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *buf = malloc(strlen(s) + 1);
 a28:	83 ec 0c             	sub    $0xc,%esp
 a2b:	53                   	push   %ebx
 a2c:	e8 6f f9 ff ff       	call   3a0 <strlen>
 a31:	83 c0 01             	add    $0x1,%eax
 a34:	89 04 24             	mov    %eax,(%esp)
 a37:	e8 c4 fe ff ff       	call   900 <malloc>
 a3c:	89 c6                	mov    %eax,%esi
  strcpy(buf, s);
 a3e:	58                   	pop    %eax
 a3f:	5a                   	pop    %edx
 a40:	53                   	push   %ebx
 a41:	56                   	push   %esi
 a42:	e8 d9 f8 ff ff       	call   320 <strcpy>
  return buf;
}
 a47:	8d 65 f8             	lea    -0x8(%ebp),%esp
 a4a:	89 f0                	mov    %esi,%eax
 a4c:	5b                   	pop    %ebx
 a4d:	5e                   	pop    %esi
 a4e:	5d                   	pop    %ebp
 a4f:	c3                   	ret    
