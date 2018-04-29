
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

int
main(void)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 04             	sub    $0x4,%esp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
      11:	eb 0e                	jmp    21 <main+0x21>
      13:	90                   	nop
      14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(fd >= 3){
      18:	83 f8 02             	cmp    $0x2,%eax
      1b:	0f 8f c3 00 00 00    	jg     e4 <main+0xe4>
  while((fd = open("console", O_RDWR)) >= 0){
      21:	83 ec 08             	sub    $0x8,%esp
      24:	6a 02                	push   $0x2
      26:	68 a1 12 00 00       	push   $0x12a1
      2b:	e8 12 0d 00 00       	call   d42 <open>
      30:	83 c4 10             	add    $0x10,%esp
      33:	85 c0                	test   %eax,%eax
      35:	79 e1                	jns    18 <main+0x18>
      37:	eb 2e                	jmp    67 <main+0x67>
      39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      40:	80 3d 22 19 00 00 20 	cmpb   $0x20,0x1922
      47:	74 5d                	je     a6 <main+0xa6>
      49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
int
fork1(void)
{
  int pid;

  pid = fork();
      50:	e8 a5 0c 00 00       	call   cfa <fork>
  if(pid == -1)
      55:	83 f8 ff             	cmp    $0xffffffff,%eax
      58:	74 3f                	je     99 <main+0x99>
    if(fork1() == 0)
      5a:	85 c0                	test   %eax,%eax
      5c:	0f 84 98 00 00 00    	je     fa <main+0xfa>
    wait();
      62:	e8 a3 0c 00 00       	call   d0a <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
      67:	83 ec 08             	sub    $0x8,%esp
      6a:	6a 64                	push   $0x64
      6c:	68 20 19 00 00       	push   $0x1920
      71:	e8 9a 00 00 00       	call   110 <getcmd>
      76:	83 c4 10             	add    $0x10,%esp
      79:	85 c0                	test   %eax,%eax
      7b:	78 78                	js     f5 <main+0xf5>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      7d:	80 3d 20 19 00 00 63 	cmpb   $0x63,0x1920
      84:	75 ca                	jne    50 <main+0x50>
      86:	80 3d 21 19 00 00 64 	cmpb   $0x64,0x1921
      8d:	74 b1                	je     40 <main+0x40>
  pid = fork();
      8f:	e8 66 0c 00 00       	call   cfa <fork>
  if(pid == -1)
      94:	83 f8 ff             	cmp    $0xffffffff,%eax
      97:	75 c1                	jne    5a <main+0x5a>
    panic("fork");
      99:	83 ec 0c             	sub    $0xc,%esp
      9c:	68 2a 12 00 00       	push   $0x122a
      a1:	e8 ba 00 00 00       	call   160 <panic>
      buf[strlen(buf)-1] = 0;  // chop \n
      a6:	83 ec 0c             	sub    $0xc,%esp
      a9:	68 20 19 00 00       	push   $0x1920
      ae:	e8 8d 0a 00 00       	call   b40 <strlen>
      if(chdir(buf+3) < 0)
      b3:	c7 04 24 23 19 00 00 	movl   $0x1923,(%esp)
      buf[strlen(buf)-1] = 0;  // chop \n
      ba:	c6 80 1f 19 00 00 00 	movb   $0x0,0x191f(%eax)
      if(chdir(buf+3) < 0)
      c1:	e8 ac 0c 00 00       	call   d72 <chdir>
      c6:	83 c4 10             	add    $0x10,%esp
      c9:	85 c0                	test   %eax,%eax
      cb:	79 9a                	jns    67 <main+0x67>
        printf(2, "cannot cd %s\n", buf+3);
      cd:	50                   	push   %eax
      ce:	68 23 19 00 00       	push   $0x1923
      d3:	68 a9 12 00 00       	push   $0x12a9
      d8:	6a 02                	push   $0x2
      da:	e8 91 0d 00 00       	call   e70 <printf>
      df:	83 c4 10             	add    $0x10,%esp
      e2:	eb 83                	jmp    67 <main+0x67>
      close(fd);
      e4:	83 ec 0c             	sub    $0xc,%esp
      e7:	50                   	push   %eax
      e8:	e8 3d 0c 00 00       	call   d2a <close>
      break;
      ed:	83 c4 10             	add    $0x10,%esp
      f0:	e9 72 ff ff ff       	jmp    67 <main+0x67>
  exit();
      f5:	e8 08 0c 00 00       	call   d02 <exit>
      runcmd(parsecmd(buf));
      fa:	83 ec 0c             	sub    $0xc,%esp
      fd:	68 20 19 00 00       	push   $0x1920
     102:	e8 49 09 00 00       	call   a50 <parsecmd>
     107:	89 04 24             	mov    %eax,(%esp)
     10a:	e8 71 00 00 00       	call   180 <runcmd>
     10f:	90                   	nop

00000110 <getcmd>:
{
     110:	55                   	push   %ebp
     111:	89 e5                	mov    %esp,%ebp
     113:	56                   	push   %esi
     114:	53                   	push   %ebx
     115:	8b 75 0c             	mov    0xc(%ebp),%esi
     118:	8b 5d 08             	mov    0x8(%ebp),%ebx
  printf(2, "$ ");
     11b:	83 ec 08             	sub    $0x8,%esp
     11e:	68 00 12 00 00       	push   $0x1200
     123:	6a 02                	push   $0x2
     125:	e8 46 0d 00 00       	call   e70 <printf>
  memset(buf, 0, nbuf);
     12a:	83 c4 0c             	add    $0xc,%esp
     12d:	56                   	push   %esi
     12e:	6a 00                	push   $0x0
     130:	53                   	push   %ebx
     131:	e8 3a 0a 00 00       	call   b70 <memset>
  gets(buf, nbuf);
     136:	58                   	pop    %eax
     137:	5a                   	pop    %edx
     138:	56                   	push   %esi
     139:	53                   	push   %ebx
     13a:	e8 91 0a 00 00       	call   bd0 <gets>
  if(buf[0] == 0) // EOF
     13f:	83 c4 10             	add    $0x10,%esp
     142:	31 c0                	xor    %eax,%eax
     144:	80 3b 00             	cmpb   $0x0,(%ebx)
     147:	0f 94 c0             	sete   %al
}
     14a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  if(buf[0] == 0) // EOF
     14d:	f7 d8                	neg    %eax
}
     14f:	5b                   	pop    %ebx
     150:	5e                   	pop    %esi
     151:	5d                   	pop    %ebp
     152:	c3                   	ret    
     153:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000160 <panic>:
{
     160:	55                   	push   %ebp
     161:	89 e5                	mov    %esp,%ebp
     163:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
     166:	ff 75 08             	pushl  0x8(%ebp)
     169:	68 9d 12 00 00       	push   $0x129d
     16e:	6a 02                	push   $0x2
     170:	e8 fb 0c 00 00       	call   e70 <printf>
  exit();
     175:	e8 88 0b 00 00       	call   d02 <exit>
     17a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000180 <runcmd>:
{
     180:	55                   	push   %ebp
     181:	89 e5                	mov    %esp,%ebp
     183:	53                   	push   %ebx
     184:	83 ec 14             	sub    $0x14,%esp
     187:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     18a:	85 db                	test   %ebx,%ebx
     18c:	74 76                	je     204 <runcmd+0x84>
  switch(cmd->type){
     18e:	83 3b 05             	cmpl   $0x5,(%ebx)
     191:	0f 87 f8 00 00 00    	ja     28f <runcmd+0x10f>
     197:	8b 03                	mov    (%ebx),%eax
     199:	ff 24 85 b8 12 00 00 	jmp    *0x12b8(,%eax,4)
    if(pipe(p) < 0)
     1a0:	8d 45 f0             	lea    -0x10(%ebp),%eax
     1a3:	83 ec 0c             	sub    $0xc,%esp
     1a6:	50                   	push   %eax
     1a7:	e8 66 0b 00 00       	call   d12 <pipe>
     1ac:	83 c4 10             	add    $0x10,%esp
     1af:	85 c0                	test   %eax,%eax
     1b1:	0f 88 07 01 00 00    	js     2be <runcmd+0x13e>
  pid = fork();
     1b7:	e8 3e 0b 00 00       	call   cfa <fork>
  if(pid == -1)
     1bc:	83 f8 ff             	cmp    $0xffffffff,%eax
     1bf:	0f 84 d7 00 00 00    	je     29c <runcmd+0x11c>
    if(fork1() == 0){
     1c5:	85 c0                	test   %eax,%eax
     1c7:	0f 84 fe 00 00 00    	je     2cb <runcmd+0x14b>
  pid = fork();
     1cd:	e8 28 0b 00 00       	call   cfa <fork>
  if(pid == -1)
     1d2:	83 f8 ff             	cmp    $0xffffffff,%eax
     1d5:	0f 84 c1 00 00 00    	je     29c <runcmd+0x11c>
    if(fork1() == 0){
     1db:	85 c0                	test   %eax,%eax
     1dd:	0f 84 0f 01 00 00    	je     2f2 <runcmd+0x172>
    close(p[0]);
     1e3:	83 ec 0c             	sub    $0xc,%esp
     1e6:	ff 75 f0             	pushl  -0x10(%ebp)
     1e9:	e8 3c 0b 00 00       	call   d2a <close>
    close(p[1]);
     1ee:	58                   	pop    %eax
     1ef:	ff 75 f4             	pushl  -0xc(%ebp)
     1f2:	e8 33 0b 00 00       	call   d2a <close>
    wait();
     1f7:	e8 0e 0b 00 00       	call   d0a <wait>
    wait();
     1fc:	e8 09 0b 00 00       	call   d0a <wait>
    break;
     201:	83 c4 10             	add    $0x10,%esp
    exit();
     204:	e8 f9 0a 00 00       	call   d02 <exit>
  pid = fork();
     209:	e8 ec 0a 00 00       	call   cfa <fork>
  if(pid == -1)
     20e:	83 f8 ff             	cmp    $0xffffffff,%eax
     211:	0f 84 85 00 00 00    	je     29c <runcmd+0x11c>
    if(fork1() == 0)
     217:	85 c0                	test   %eax,%eax
     219:	75 e9                	jne    204 <runcmd+0x84>
     21b:	eb 49                	jmp    266 <runcmd+0xe6>
    if(ecmd->argv[0] == 0)
     21d:	8b 43 04             	mov    0x4(%ebx),%eax
     220:	85 c0                	test   %eax,%eax
     222:	74 e0                	je     204 <runcmd+0x84>
    exec(ecmd->argv[0], ecmd->argv);
     224:	52                   	push   %edx
     225:	52                   	push   %edx
     226:	8d 53 04             	lea    0x4(%ebx),%edx
     229:	52                   	push   %edx
     22a:	50                   	push   %eax
     22b:	e8 0a 0b 00 00       	call   d3a <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     230:	83 c4 0c             	add    $0xc,%esp
     233:	ff 73 04             	pushl  0x4(%ebx)
     236:	68 0a 12 00 00       	push   $0x120a
     23b:	6a 02                	push   $0x2
     23d:	e8 2e 0c 00 00       	call   e70 <printf>
    break;
     242:	83 c4 10             	add    $0x10,%esp
     245:	eb bd                	jmp    204 <runcmd+0x84>
    close(rcmd->fd);
     247:	83 ec 0c             	sub    $0xc,%esp
     24a:	ff 73 14             	pushl  0x14(%ebx)
     24d:	e8 d8 0a 00 00       	call   d2a <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     252:	59                   	pop    %ecx
     253:	58                   	pop    %eax
     254:	ff 73 10             	pushl  0x10(%ebx)
     257:	ff 73 08             	pushl  0x8(%ebx)
     25a:	e8 e3 0a 00 00       	call   d42 <open>
     25f:	83 c4 10             	add    $0x10,%esp
     262:	85 c0                	test   %eax,%eax
     264:	78 43                	js     2a9 <runcmd+0x129>
      runcmd(bcmd->cmd);
     266:	83 ec 0c             	sub    $0xc,%esp
     269:	ff 73 04             	pushl  0x4(%ebx)
     26c:	e8 0f ff ff ff       	call   180 <runcmd>
  pid = fork();
     271:	e8 84 0a 00 00       	call   cfa <fork>
  if(pid == -1)
     276:	83 f8 ff             	cmp    $0xffffffff,%eax
     279:	74 21                	je     29c <runcmd+0x11c>
    if(fork1() == 0)
     27b:	85 c0                	test   %eax,%eax
     27d:	74 e7                	je     266 <runcmd+0xe6>
    wait();
     27f:	e8 86 0a 00 00       	call   d0a <wait>
    runcmd(lcmd->right);
     284:	83 ec 0c             	sub    $0xc,%esp
     287:	ff 73 08             	pushl  0x8(%ebx)
     28a:	e8 f1 fe ff ff       	call   180 <runcmd>
    panic("runcmd");
     28f:	83 ec 0c             	sub    $0xc,%esp
     292:	68 03 12 00 00       	push   $0x1203
     297:	e8 c4 fe ff ff       	call   160 <panic>
    panic("fork");
     29c:	83 ec 0c             	sub    $0xc,%esp
     29f:	68 2a 12 00 00       	push   $0x122a
     2a4:	e8 b7 fe ff ff       	call   160 <panic>
      printf(2, "open %s failed\n", rcmd->file);
     2a9:	52                   	push   %edx
     2aa:	ff 73 08             	pushl  0x8(%ebx)
     2ad:	68 1a 12 00 00       	push   $0x121a
     2b2:	6a 02                	push   $0x2
     2b4:	e8 b7 0b 00 00       	call   e70 <printf>
      exit();
     2b9:	e8 44 0a 00 00       	call   d02 <exit>
      panic("pipe");
     2be:	83 ec 0c             	sub    $0xc,%esp
     2c1:	68 2f 12 00 00       	push   $0x122f
     2c6:	e8 95 fe ff ff       	call   160 <panic>
      dup2(p[1], 1);
     2cb:	50                   	push   %eax
     2cc:	50                   	push   %eax
     2cd:	6a 01                	push   $0x1
     2cf:	ff 75 f4             	pushl  -0xc(%ebp)
     2d2:	e8 cb 0a 00 00       	call   da2 <dup2>
      close(p[0]);
     2d7:	58                   	pop    %eax
     2d8:	ff 75 f0             	pushl  -0x10(%ebp)
     2db:	e8 4a 0a 00 00       	call   d2a <close>
      close(p[1]);
     2e0:	58                   	pop    %eax
     2e1:	ff 75 f4             	pushl  -0xc(%ebp)
     2e4:	e8 41 0a 00 00       	call   d2a <close>
      runcmd(pcmd->left);
     2e9:	58                   	pop    %eax
     2ea:	ff 73 04             	pushl  0x4(%ebx)
     2ed:	e8 8e fe ff ff       	call   180 <runcmd>
      dup2(p[0], 0);
     2f2:	52                   	push   %edx
     2f3:	52                   	push   %edx
     2f4:	6a 00                	push   $0x0
     2f6:	ff 75 f0             	pushl  -0x10(%ebp)
     2f9:	e8 a4 0a 00 00       	call   da2 <dup2>
      close(p[0]);
     2fe:	59                   	pop    %ecx
     2ff:	ff 75 f0             	pushl  -0x10(%ebp)
     302:	e8 23 0a 00 00       	call   d2a <close>
      close(p[1]);
     307:	58                   	pop    %eax
     308:	ff 75 f4             	pushl  -0xc(%ebp)
     30b:	e8 1a 0a 00 00       	call   d2a <close>
      runcmd(pcmd->right);
     310:	58                   	pop    %eax
     311:	ff 73 08             	pushl  0x8(%ebx)
     314:	e8 67 fe ff ff       	call   180 <runcmd>
     319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000320 <fork1>:
{
     320:	55                   	push   %ebp
     321:	89 e5                	mov    %esp,%ebp
     323:	83 ec 08             	sub    $0x8,%esp
  pid = fork();
     326:	e8 cf 09 00 00       	call   cfa <fork>
  if(pid == -1)
     32b:	83 f8 ff             	cmp    $0xffffffff,%eax
     32e:	74 02                	je     332 <fork1+0x12>
  return pid;
}
     330:	c9                   	leave  
     331:	c3                   	ret    
    panic("fork");
     332:	83 ec 0c             	sub    $0xc,%esp
     335:	68 2a 12 00 00       	push   $0x122a
     33a:	e8 21 fe ff ff       	call   160 <panic>
     33f:	90                   	nop

00000340 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     340:	55                   	push   %ebp
     341:	89 e5                	mov    %esp,%ebp
     343:	53                   	push   %ebx
     344:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     347:	6a 54                	push   $0x54
     349:	e8 62 0d 00 00       	call   10b0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     34e:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     351:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     353:	6a 54                	push   $0x54
     355:	6a 00                	push   $0x0
     357:	50                   	push   %eax
     358:	e8 13 08 00 00       	call   b70 <memset>
  cmd->type = EXEC;
     35d:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     363:	89 d8                	mov    %ebx,%eax
     365:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     368:	c9                   	leave  
     369:	c3                   	ret    
     36a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000370 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     370:	55                   	push   %ebp
     371:	89 e5                	mov    %esp,%ebp
     373:	53                   	push   %ebx
     374:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     377:	6a 18                	push   $0x18
     379:	e8 32 0d 00 00       	call   10b0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     37e:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     381:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     383:	6a 18                	push   $0x18
     385:	6a 00                	push   $0x0
     387:	50                   	push   %eax
     388:	e8 e3 07 00 00       	call   b70 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     38d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     390:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     396:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     399:	8b 45 0c             	mov    0xc(%ebp),%eax
     39c:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     39f:	8b 45 10             	mov    0x10(%ebp),%eax
     3a2:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     3a5:	8b 45 14             	mov    0x14(%ebp),%eax
     3a8:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     3ab:	8b 45 18             	mov    0x18(%ebp),%eax
     3ae:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     3b1:	89 d8                	mov    %ebx,%eax
     3b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     3b6:	c9                   	leave  
     3b7:	c3                   	ret    
     3b8:	90                   	nop
     3b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003c0 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     3c0:	55                   	push   %ebp
     3c1:	89 e5                	mov    %esp,%ebp
     3c3:	53                   	push   %ebx
     3c4:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3c7:	6a 0c                	push   $0xc
     3c9:	e8 e2 0c 00 00       	call   10b0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3ce:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     3d1:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3d3:	6a 0c                	push   $0xc
     3d5:	6a 00                	push   $0x0
     3d7:	50                   	push   %eax
     3d8:	e8 93 07 00 00       	call   b70 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     3dd:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     3e0:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     3e6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     3e9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3ec:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     3ef:	89 d8                	mov    %ebx,%eax
     3f1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     3f4:	c9                   	leave  
     3f5:	c3                   	ret    
     3f6:	8d 76 00             	lea    0x0(%esi),%esi
     3f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000400 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     400:	55                   	push   %ebp
     401:	89 e5                	mov    %esp,%ebp
     403:	53                   	push   %ebx
     404:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     407:	6a 0c                	push   $0xc
     409:	e8 a2 0c 00 00       	call   10b0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     40e:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     411:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     413:	6a 0c                	push   $0xc
     415:	6a 00                	push   $0x0
     417:	50                   	push   %eax
     418:	e8 53 07 00 00       	call   b70 <memset>
  cmd->type = LIST;
  cmd->left = left;
     41d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     420:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     426:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     429:	8b 45 0c             	mov    0xc(%ebp),%eax
     42c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     42f:	89 d8                	mov    %ebx,%eax
     431:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     434:	c9                   	leave  
     435:	c3                   	ret    
     436:	8d 76 00             	lea    0x0(%esi),%esi
     439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000440 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     440:	55                   	push   %ebp
     441:	89 e5                	mov    %esp,%ebp
     443:	53                   	push   %ebx
     444:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     447:	6a 08                	push   $0x8
     449:	e8 62 0c 00 00       	call   10b0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     44e:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     451:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     453:	6a 08                	push   $0x8
     455:	6a 00                	push   $0x0
     457:	50                   	push   %eax
     458:	e8 13 07 00 00       	call   b70 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     45d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     460:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     466:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     469:	89 d8                	mov    %ebx,%eax
     46b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     46e:	c9                   	leave  
     46f:	c3                   	ret    

00000470 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     470:	55                   	push   %ebp
     471:	89 e5                	mov    %esp,%ebp
     473:	57                   	push   %edi
     474:	56                   	push   %esi
     475:	53                   	push   %ebx
     476:	83 ec 0c             	sub    $0xc,%esp
  char *s;
  int ret;

  s = *ps;
     479:	8b 45 08             	mov    0x8(%ebp),%eax
{
     47c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     47f:	8b 7d 10             	mov    0x10(%ebp),%edi
  s = *ps;
     482:	8b 30                	mov    (%eax),%esi
  while(s < es && strchr(whitespace, *s))
     484:	39 de                	cmp    %ebx,%esi
     486:	72 0f                	jb     497 <gettoken+0x27>
     488:	eb 25                	jmp    4af <gettoken+0x3f>
     48a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     490:	83 c6 01             	add    $0x1,%esi
  while(s < es && strchr(whitespace, *s))
     493:	39 f3                	cmp    %esi,%ebx
     495:	74 18                	je     4af <gettoken+0x3f>
     497:	0f be 06             	movsbl (%esi),%eax
     49a:	83 ec 08             	sub    $0x8,%esp
     49d:	50                   	push   %eax
     49e:	68 fc 18 00 00       	push   $0x18fc
     4a3:	e8 e8 06 00 00       	call   b90 <strchr>
     4a8:	83 c4 10             	add    $0x10,%esp
     4ab:	85 c0                	test   %eax,%eax
     4ad:	75 e1                	jne    490 <gettoken+0x20>
  if(q)
     4af:	85 ff                	test   %edi,%edi
     4b1:	74 02                	je     4b5 <gettoken+0x45>
    *q = s;
     4b3:	89 37                	mov    %esi,(%edi)
  ret = *s;
     4b5:	0f be 06             	movsbl (%esi),%eax
  switch(*s){
     4b8:	3c 29                	cmp    $0x29,%al
     4ba:	7f 54                	jg     510 <gettoken+0xa0>
     4bc:	3c 28                	cmp    $0x28,%al
     4be:	0f 8d c8 00 00 00    	jge    58c <gettoken+0x11c>
     4c4:	31 ff                	xor    %edi,%edi
     4c6:	84 c0                	test   %al,%al
     4c8:	0f 85 e2 00 00 00    	jne    5b0 <gettoken+0x140>
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     4ce:	8b 55 14             	mov    0x14(%ebp),%edx
     4d1:	85 d2                	test   %edx,%edx
     4d3:	74 05                	je     4da <gettoken+0x6a>
    *eq = s;
     4d5:	8b 45 14             	mov    0x14(%ebp),%eax
     4d8:	89 30                	mov    %esi,(%eax)

  while(s < es && strchr(whitespace, *s))
     4da:	39 f3                	cmp    %esi,%ebx
     4dc:	77 09                	ja     4e7 <gettoken+0x77>
     4de:	eb 1f                	jmp    4ff <gettoken+0x8f>
    s++;
     4e0:	83 c6 01             	add    $0x1,%esi
  while(s < es && strchr(whitespace, *s))
     4e3:	39 f3                	cmp    %esi,%ebx
     4e5:	74 18                	je     4ff <gettoken+0x8f>
     4e7:	0f be 06             	movsbl (%esi),%eax
     4ea:	83 ec 08             	sub    $0x8,%esp
     4ed:	50                   	push   %eax
     4ee:	68 fc 18 00 00       	push   $0x18fc
     4f3:	e8 98 06 00 00       	call   b90 <strchr>
     4f8:	83 c4 10             	add    $0x10,%esp
     4fb:	85 c0                	test   %eax,%eax
     4fd:	75 e1                	jne    4e0 <gettoken+0x70>
  *ps = s;
     4ff:	8b 45 08             	mov    0x8(%ebp),%eax
     502:	89 30                	mov    %esi,(%eax)
  return ret;
}
     504:	8d 65 f4             	lea    -0xc(%ebp),%esp
     507:	89 f8                	mov    %edi,%eax
     509:	5b                   	pop    %ebx
     50a:	5e                   	pop    %esi
     50b:	5f                   	pop    %edi
     50c:	5d                   	pop    %ebp
     50d:	c3                   	ret    
     50e:	66 90                	xchg   %ax,%ax
  switch(*s){
     510:	3c 3e                	cmp    $0x3e,%al
     512:	75 1c                	jne    530 <gettoken+0xc0>
    if(*s == '>'){
     514:	80 7e 01 3e          	cmpb   $0x3e,0x1(%esi)
     518:	0f 84 82 00 00 00    	je     5a0 <gettoken+0x130>
    s++;
     51e:	83 c6 01             	add    $0x1,%esi
     521:	bf 3e 00 00 00       	mov    $0x3e,%edi
     526:	eb a6                	jmp    4ce <gettoken+0x5e>
     528:	90                   	nop
     529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     530:	7f 56                	jg     588 <gettoken+0x118>
     532:	8d 48 c5             	lea    -0x3b(%eax),%ecx
     535:	80 f9 01             	cmp    $0x1,%cl
     538:	76 52                	jbe    58c <gettoken+0x11c>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     53a:	39 f3                	cmp    %esi,%ebx
     53c:	77 24                	ja     562 <gettoken+0xf2>
     53e:	eb 7a                	jmp    5ba <gettoken+0x14a>
     540:	0f be 06             	movsbl (%esi),%eax
     543:	83 ec 08             	sub    $0x8,%esp
     546:	50                   	push   %eax
     547:	68 f4 18 00 00       	push   $0x18f4
     54c:	e8 3f 06 00 00       	call   b90 <strchr>
     551:	83 c4 10             	add    $0x10,%esp
     554:	85 c0                	test   %eax,%eax
     556:	75 1f                	jne    577 <gettoken+0x107>
      s++;
     558:	83 c6 01             	add    $0x1,%esi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     55b:	39 f3                	cmp    %esi,%ebx
     55d:	74 5b                	je     5ba <gettoken+0x14a>
     55f:	0f be 06             	movsbl (%esi),%eax
     562:	83 ec 08             	sub    $0x8,%esp
     565:	50                   	push   %eax
     566:	68 fc 18 00 00       	push   $0x18fc
     56b:	e8 20 06 00 00       	call   b90 <strchr>
     570:	83 c4 10             	add    $0x10,%esp
     573:	85 c0                	test   %eax,%eax
     575:	74 c9                	je     540 <gettoken+0xd0>
    ret = 'a';
     577:	bf 61 00 00 00       	mov    $0x61,%edi
     57c:	e9 4d ff ff ff       	jmp    4ce <gettoken+0x5e>
     581:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     588:	3c 7c                	cmp    $0x7c,%al
     58a:	75 ae                	jne    53a <gettoken+0xca>
  ret = *s;
     58c:	0f be f8             	movsbl %al,%edi
    s++;
     58f:	83 c6 01             	add    $0x1,%esi
    break;
     592:	e9 37 ff ff ff       	jmp    4ce <gettoken+0x5e>
     597:	89 f6                	mov    %esi,%esi
     599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      s++;
     5a0:	83 c6 02             	add    $0x2,%esi
      ret = '+';
     5a3:	bf 2b 00 00 00       	mov    $0x2b,%edi
     5a8:	e9 21 ff ff ff       	jmp    4ce <gettoken+0x5e>
     5ad:	8d 76 00             	lea    0x0(%esi),%esi
  switch(*s){
     5b0:	3c 26                	cmp    $0x26,%al
     5b2:	0f 85 82 ff ff ff    	jne    53a <gettoken+0xca>
     5b8:	eb d2                	jmp    58c <gettoken+0x11c>
  if(eq)
     5ba:	8b 45 14             	mov    0x14(%ebp),%eax
     5bd:	bf 61 00 00 00       	mov    $0x61,%edi
     5c2:	85 c0                	test   %eax,%eax
     5c4:	0f 85 0b ff ff ff    	jne    4d5 <gettoken+0x65>
     5ca:	e9 30 ff ff ff       	jmp    4ff <gettoken+0x8f>
     5cf:	90                   	nop

000005d0 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     5d0:	55                   	push   %ebp
     5d1:	89 e5                	mov    %esp,%ebp
     5d3:	57                   	push   %edi
     5d4:	56                   	push   %esi
     5d5:	53                   	push   %ebx
     5d6:	83 ec 0c             	sub    $0xc,%esp
     5d9:	8b 7d 08             	mov    0x8(%ebp),%edi
     5dc:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     5df:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     5e1:	39 f3                	cmp    %esi,%ebx
     5e3:	72 12                	jb     5f7 <peek+0x27>
     5e5:	eb 28                	jmp    60f <peek+0x3f>
     5e7:	89 f6                	mov    %esi,%esi
     5e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    s++;
     5f0:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
     5f3:	39 de                	cmp    %ebx,%esi
     5f5:	74 18                	je     60f <peek+0x3f>
     5f7:	0f be 03             	movsbl (%ebx),%eax
     5fa:	83 ec 08             	sub    $0x8,%esp
     5fd:	50                   	push   %eax
     5fe:	68 fc 18 00 00       	push   $0x18fc
     603:	e8 88 05 00 00       	call   b90 <strchr>
     608:	83 c4 10             	add    $0x10,%esp
     60b:	85 c0                	test   %eax,%eax
     60d:	75 e1                	jne    5f0 <peek+0x20>
  *ps = s;
     60f:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     611:	0f be 13             	movsbl (%ebx),%edx
     614:	31 c0                	xor    %eax,%eax
     616:	84 d2                	test   %dl,%dl
     618:	74 17                	je     631 <peek+0x61>
     61a:	83 ec 08             	sub    $0x8,%esp
     61d:	52                   	push   %edx
     61e:	ff 75 10             	pushl  0x10(%ebp)
     621:	e8 6a 05 00 00       	call   b90 <strchr>
     626:	83 c4 10             	add    $0x10,%esp
     629:	85 c0                	test   %eax,%eax
     62b:	0f 95 c0             	setne  %al
     62e:	0f b6 c0             	movzbl %al,%eax
}
     631:	8d 65 f4             	lea    -0xc(%ebp),%esp
     634:	5b                   	pop    %ebx
     635:	5e                   	pop    %esi
     636:	5f                   	pop    %edi
     637:	5d                   	pop    %ebp
     638:	c3                   	ret    
     639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000640 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     640:	55                   	push   %ebp
     641:	89 e5                	mov    %esp,%ebp
     643:	57                   	push   %edi
     644:	56                   	push   %esi
     645:	53                   	push   %ebx
     646:	83 ec 1c             	sub    $0x1c,%esp
     649:	8b 75 0c             	mov    0xc(%ebp),%esi
     64c:	8b 5d 10             	mov    0x10(%ebp),%ebx
     64f:	90                   	nop
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     650:	83 ec 04             	sub    $0x4,%esp
     653:	68 51 12 00 00       	push   $0x1251
     658:	53                   	push   %ebx
     659:	56                   	push   %esi
     65a:	e8 71 ff ff ff       	call   5d0 <peek>
     65f:	83 c4 10             	add    $0x10,%esp
     662:	85 c0                	test   %eax,%eax
     664:	74 6a                	je     6d0 <parseredirs+0x90>
    tok = gettoken(ps, es, 0, 0);
     666:	6a 00                	push   $0x0
     668:	6a 00                	push   $0x0
     66a:	53                   	push   %ebx
     66b:	56                   	push   %esi
     66c:	e8 ff fd ff ff       	call   470 <gettoken>
     671:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     673:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     676:	50                   	push   %eax
     677:	8d 45 e0             	lea    -0x20(%ebp),%eax
     67a:	50                   	push   %eax
     67b:	53                   	push   %ebx
     67c:	56                   	push   %esi
     67d:	e8 ee fd ff ff       	call   470 <gettoken>
     682:	83 c4 20             	add    $0x20,%esp
     685:	83 f8 61             	cmp    $0x61,%eax
     688:	75 51                	jne    6db <parseredirs+0x9b>
      panic("missing file for redirection");
    switch(tok){
     68a:	83 ff 3c             	cmp    $0x3c,%edi
     68d:	74 31                	je     6c0 <parseredirs+0x80>
     68f:	83 ff 3e             	cmp    $0x3e,%edi
     692:	74 05                	je     699 <parseredirs+0x59>
     694:	83 ff 2b             	cmp    $0x2b,%edi
     697:	75 b7                	jne    650 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     699:	83 ec 0c             	sub    $0xc,%esp
     69c:	6a 01                	push   $0x1
     69e:	68 01 02 00 00       	push   $0x201
     6a3:	ff 75 e4             	pushl  -0x1c(%ebp)
     6a6:	ff 75 e0             	pushl  -0x20(%ebp)
     6a9:	ff 75 08             	pushl  0x8(%ebp)
     6ac:	e8 bf fc ff ff       	call   370 <redircmd>
      break;
     6b1:	83 c4 20             	add    $0x20,%esp
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     6b4:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     6b7:	eb 97                	jmp    650 <parseredirs+0x10>
     6b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     6c0:	83 ec 0c             	sub    $0xc,%esp
     6c3:	6a 00                	push   $0x0
     6c5:	6a 00                	push   $0x0
     6c7:	eb da                	jmp    6a3 <parseredirs+0x63>
     6c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
  }
  return cmd;
}
     6d0:	8b 45 08             	mov    0x8(%ebp),%eax
     6d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     6d6:	5b                   	pop    %ebx
     6d7:	5e                   	pop    %esi
     6d8:	5f                   	pop    %edi
     6d9:	5d                   	pop    %ebp
     6da:	c3                   	ret    
      panic("missing file for redirection");
     6db:	83 ec 0c             	sub    $0xc,%esp
     6de:	68 34 12 00 00       	push   $0x1234
     6e3:	e8 78 fa ff ff       	call   160 <panic>
     6e8:	90                   	nop
     6e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006f0 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     6f0:	55                   	push   %ebp
     6f1:	89 e5                	mov    %esp,%ebp
     6f3:	57                   	push   %edi
     6f4:	56                   	push   %esi
     6f5:	53                   	push   %ebx
     6f6:	83 ec 30             	sub    $0x30,%esp
     6f9:	8b 75 08             	mov    0x8(%ebp),%esi
     6fc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     6ff:	68 54 12 00 00       	push   $0x1254
     704:	57                   	push   %edi
     705:	56                   	push   %esi
     706:	e8 c5 fe ff ff       	call   5d0 <peek>
     70b:	83 c4 10             	add    $0x10,%esp
     70e:	85 c0                	test   %eax,%eax
     710:	0f 85 92 00 00 00    	jne    7a8 <parseexec+0xb8>
     716:	89 c3                	mov    %eax,%ebx
    return parseblock(ps, es);

  ret = execcmd();
     718:	e8 23 fc ff ff       	call   340 <execcmd>
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     71d:	83 ec 04             	sub    $0x4,%esp
  ret = execcmd();
     720:	89 45 d0             	mov    %eax,-0x30(%ebp)
  ret = parseredirs(ret, ps, es);
     723:	57                   	push   %edi
     724:	56                   	push   %esi
     725:	50                   	push   %eax
     726:	e8 15 ff ff ff       	call   640 <parseredirs>
     72b:	83 c4 10             	add    $0x10,%esp
     72e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     731:	eb 18                	jmp    74b <parseexec+0x5b>
     733:	90                   	nop
     734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     738:	83 ec 04             	sub    $0x4,%esp
     73b:	57                   	push   %edi
     73c:	56                   	push   %esi
     73d:	ff 75 d4             	pushl  -0x2c(%ebp)
     740:	e8 fb fe ff ff       	call   640 <parseredirs>
     745:	83 c4 10             	add    $0x10,%esp
     748:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     74b:	83 ec 04             	sub    $0x4,%esp
     74e:	68 6b 12 00 00       	push   $0x126b
     753:	57                   	push   %edi
     754:	56                   	push   %esi
     755:	e8 76 fe ff ff       	call   5d0 <peek>
     75a:	83 c4 10             	add    $0x10,%esp
     75d:	85 c0                	test   %eax,%eax
     75f:	75 67                	jne    7c8 <parseexec+0xd8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     761:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     764:	50                   	push   %eax
     765:	8d 45 e0             	lea    -0x20(%ebp),%eax
     768:	50                   	push   %eax
     769:	57                   	push   %edi
     76a:	56                   	push   %esi
     76b:	e8 00 fd ff ff       	call   470 <gettoken>
     770:	83 c4 10             	add    $0x10,%esp
     773:	85 c0                	test   %eax,%eax
     775:	74 51                	je     7c8 <parseexec+0xd8>
    if(tok != 'a')
     777:	83 f8 61             	cmp    $0x61,%eax
     77a:	75 6b                	jne    7e7 <parseexec+0xf7>
    cmd->argv[argc] = q;
     77c:	8b 45 e0             	mov    -0x20(%ebp),%eax
     77f:	8b 55 d0             	mov    -0x30(%ebp),%edx
     782:	89 44 9a 04          	mov    %eax,0x4(%edx,%ebx,4)
    cmd->eargv[argc] = eq;
     786:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     789:	89 44 9a 2c          	mov    %eax,0x2c(%edx,%ebx,4)
    argc++;
     78d:	83 c3 01             	add    $0x1,%ebx
    if(argc >= MAXARGS)
     790:	83 fb 0a             	cmp    $0xa,%ebx
     793:	75 a3                	jne    738 <parseexec+0x48>
      panic("too many args");
     795:	83 ec 0c             	sub    $0xc,%esp
     798:	68 5d 12 00 00       	push   $0x125d
     79d:	e8 be f9 ff ff       	call   160 <panic>
     7a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     7a8:	83 ec 08             	sub    $0x8,%esp
     7ab:	57                   	push   %edi
     7ac:	56                   	push   %esi
     7ad:	e8 5e 01 00 00       	call   910 <parseblock>
     7b2:	83 c4 10             	add    $0x10,%esp
     7b5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     7b8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     7bb:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7be:	5b                   	pop    %ebx
     7bf:	5e                   	pop    %esi
     7c0:	5f                   	pop    %edi
     7c1:	5d                   	pop    %ebp
     7c2:	c3                   	ret    
     7c3:	90                   	nop
     7c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     7c8:	8b 45 d0             	mov    -0x30(%ebp),%eax
     7cb:	8d 04 98             	lea    (%eax,%ebx,4),%eax
  cmd->argv[argc] = 0;
     7ce:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  cmd->eargv[argc] = 0;
     7d5:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
}
     7dc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     7df:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7e2:	5b                   	pop    %ebx
     7e3:	5e                   	pop    %esi
     7e4:	5f                   	pop    %edi
     7e5:	5d                   	pop    %ebp
     7e6:	c3                   	ret    
      panic("syntax");
     7e7:	83 ec 0c             	sub    $0xc,%esp
     7ea:	68 56 12 00 00       	push   $0x1256
     7ef:	e8 6c f9 ff ff       	call   160 <panic>
     7f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     7fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000800 <parsepipe>:
{
     800:	55                   	push   %ebp
     801:	89 e5                	mov    %esp,%ebp
     803:	57                   	push   %edi
     804:	56                   	push   %esi
     805:	53                   	push   %ebx
     806:	83 ec 14             	sub    $0x14,%esp
     809:	8b 5d 08             	mov    0x8(%ebp),%ebx
     80c:	8b 75 0c             	mov    0xc(%ebp),%esi
  cmd = parseexec(ps, es);
     80f:	56                   	push   %esi
     810:	53                   	push   %ebx
     811:	e8 da fe ff ff       	call   6f0 <parseexec>
  if(peek(ps, es, "|")){
     816:	83 c4 0c             	add    $0xc,%esp
  cmd = parseexec(ps, es);
     819:	89 c7                	mov    %eax,%edi
  if(peek(ps, es, "|")){
     81b:	68 70 12 00 00       	push   $0x1270
     820:	56                   	push   %esi
     821:	53                   	push   %ebx
     822:	e8 a9 fd ff ff       	call   5d0 <peek>
     827:	83 c4 10             	add    $0x10,%esp
     82a:	85 c0                	test   %eax,%eax
     82c:	75 12                	jne    840 <parsepipe+0x40>
}
     82e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     831:	89 f8                	mov    %edi,%eax
     833:	5b                   	pop    %ebx
     834:	5e                   	pop    %esi
     835:	5f                   	pop    %edi
     836:	5d                   	pop    %ebp
     837:	c3                   	ret    
     838:	90                   	nop
     839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    gettoken(ps, es, 0, 0);
     840:	6a 00                	push   $0x0
     842:	6a 00                	push   $0x0
     844:	56                   	push   %esi
     845:	53                   	push   %ebx
     846:	e8 25 fc ff ff       	call   470 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     84b:	58                   	pop    %eax
     84c:	5a                   	pop    %edx
     84d:	56                   	push   %esi
     84e:	53                   	push   %ebx
     84f:	e8 ac ff ff ff       	call   800 <parsepipe>
     854:	89 7d 08             	mov    %edi,0x8(%ebp)
     857:	89 45 0c             	mov    %eax,0xc(%ebp)
     85a:	83 c4 10             	add    $0x10,%esp
}
     85d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     860:	5b                   	pop    %ebx
     861:	5e                   	pop    %esi
     862:	5f                   	pop    %edi
     863:	5d                   	pop    %ebp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     864:	e9 57 fb ff ff       	jmp    3c0 <pipecmd>
     869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000870 <parseline>:
{
     870:	55                   	push   %ebp
     871:	89 e5                	mov    %esp,%ebp
     873:	57                   	push   %edi
     874:	56                   	push   %esi
     875:	53                   	push   %ebx
     876:	83 ec 14             	sub    $0x14,%esp
     879:	8b 5d 08             	mov    0x8(%ebp),%ebx
     87c:	8b 75 0c             	mov    0xc(%ebp),%esi
  cmd = parsepipe(ps, es);
     87f:	56                   	push   %esi
     880:	53                   	push   %ebx
     881:	e8 7a ff ff ff       	call   800 <parsepipe>
  while(peek(ps, es, "&")){
     886:	83 c4 10             	add    $0x10,%esp
  cmd = parsepipe(ps, es);
     889:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     88b:	eb 1b                	jmp    8a8 <parseline+0x38>
     88d:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     890:	6a 00                	push   $0x0
     892:	6a 00                	push   $0x0
     894:	56                   	push   %esi
     895:	53                   	push   %ebx
     896:	e8 d5 fb ff ff       	call   470 <gettoken>
    cmd = backcmd(cmd);
     89b:	89 3c 24             	mov    %edi,(%esp)
     89e:	e8 9d fb ff ff       	call   440 <backcmd>
     8a3:	83 c4 10             	add    $0x10,%esp
     8a6:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     8a8:	83 ec 04             	sub    $0x4,%esp
     8ab:	68 72 12 00 00       	push   $0x1272
     8b0:	56                   	push   %esi
     8b1:	53                   	push   %ebx
     8b2:	e8 19 fd ff ff       	call   5d0 <peek>
     8b7:	83 c4 10             	add    $0x10,%esp
     8ba:	85 c0                	test   %eax,%eax
     8bc:	75 d2                	jne    890 <parseline+0x20>
  if(peek(ps, es, ";")){
     8be:	83 ec 04             	sub    $0x4,%esp
     8c1:	68 6e 12 00 00       	push   $0x126e
     8c6:	56                   	push   %esi
     8c7:	53                   	push   %ebx
     8c8:	e8 03 fd ff ff       	call   5d0 <peek>
     8cd:	83 c4 10             	add    $0x10,%esp
     8d0:	85 c0                	test   %eax,%eax
     8d2:	75 0c                	jne    8e0 <parseline+0x70>
}
     8d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8d7:	89 f8                	mov    %edi,%eax
     8d9:	5b                   	pop    %ebx
     8da:	5e                   	pop    %esi
     8db:	5f                   	pop    %edi
     8dc:	5d                   	pop    %ebp
     8dd:	c3                   	ret    
     8de:	66 90                	xchg   %ax,%ax
    gettoken(ps, es, 0, 0);
     8e0:	6a 00                	push   $0x0
     8e2:	6a 00                	push   $0x0
     8e4:	56                   	push   %esi
     8e5:	53                   	push   %ebx
     8e6:	e8 85 fb ff ff       	call   470 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     8eb:	58                   	pop    %eax
     8ec:	5a                   	pop    %edx
     8ed:	56                   	push   %esi
     8ee:	53                   	push   %ebx
     8ef:	e8 7c ff ff ff       	call   870 <parseline>
     8f4:	89 7d 08             	mov    %edi,0x8(%ebp)
     8f7:	89 45 0c             	mov    %eax,0xc(%ebp)
     8fa:	83 c4 10             	add    $0x10,%esp
}
     8fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
     900:	5b                   	pop    %ebx
     901:	5e                   	pop    %esi
     902:	5f                   	pop    %edi
     903:	5d                   	pop    %ebp
    cmd = listcmd(cmd, parseline(ps, es));
     904:	e9 f7 fa ff ff       	jmp    400 <listcmd>
     909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000910 <parseblock>:
{
     910:	55                   	push   %ebp
     911:	89 e5                	mov    %esp,%ebp
     913:	57                   	push   %edi
     914:	56                   	push   %esi
     915:	53                   	push   %ebx
     916:	83 ec 10             	sub    $0x10,%esp
     919:	8b 5d 08             	mov    0x8(%ebp),%ebx
     91c:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     91f:	68 54 12 00 00       	push   $0x1254
     924:	56                   	push   %esi
     925:	53                   	push   %ebx
     926:	e8 a5 fc ff ff       	call   5d0 <peek>
     92b:	83 c4 10             	add    $0x10,%esp
     92e:	85 c0                	test   %eax,%eax
     930:	74 4a                	je     97c <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     932:	6a 00                	push   $0x0
     934:	6a 00                	push   $0x0
     936:	56                   	push   %esi
     937:	53                   	push   %ebx
     938:	e8 33 fb ff ff       	call   470 <gettoken>
  cmd = parseline(ps, es);
     93d:	58                   	pop    %eax
     93e:	5a                   	pop    %edx
     93f:	56                   	push   %esi
     940:	53                   	push   %ebx
     941:	e8 2a ff ff ff       	call   870 <parseline>
  if(!peek(ps, es, ")"))
     946:	83 c4 0c             	add    $0xc,%esp
  cmd = parseline(ps, es);
     949:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     94b:	68 90 12 00 00       	push   $0x1290
     950:	56                   	push   %esi
     951:	53                   	push   %ebx
     952:	e8 79 fc ff ff       	call   5d0 <peek>
     957:	83 c4 10             	add    $0x10,%esp
     95a:	85 c0                	test   %eax,%eax
     95c:	74 2b                	je     989 <parseblock+0x79>
  gettoken(ps, es, 0, 0);
     95e:	6a 00                	push   $0x0
     960:	6a 00                	push   $0x0
     962:	56                   	push   %esi
     963:	53                   	push   %ebx
     964:	e8 07 fb ff ff       	call   470 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     969:	83 c4 0c             	add    $0xc,%esp
     96c:	56                   	push   %esi
     96d:	53                   	push   %ebx
     96e:	57                   	push   %edi
     96f:	e8 cc fc ff ff       	call   640 <parseredirs>
}
     974:	8d 65 f4             	lea    -0xc(%ebp),%esp
     977:	5b                   	pop    %ebx
     978:	5e                   	pop    %esi
     979:	5f                   	pop    %edi
     97a:	5d                   	pop    %ebp
     97b:	c3                   	ret    
    panic("parseblock");
     97c:	83 ec 0c             	sub    $0xc,%esp
     97f:	68 74 12 00 00       	push   $0x1274
     984:	e8 d7 f7 ff ff       	call   160 <panic>
    panic("syntax - missing )");
     989:	83 ec 0c             	sub    $0xc,%esp
     98c:	68 7f 12 00 00       	push   $0x127f
     991:	e8 ca f7 ff ff       	call   160 <panic>
     996:	8d 76 00             	lea    0x0(%esi),%esi
     999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009a0 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     9a0:	55                   	push   %ebp
     9a1:	89 e5                	mov    %esp,%ebp
     9a3:	53                   	push   %ebx
     9a4:	83 ec 04             	sub    $0x4,%esp
     9a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     9aa:	85 db                	test   %ebx,%ebx
     9ac:	74 20                	je     9ce <nulterminate+0x2e>
    return 0;

  switch(cmd->type){
     9ae:	83 3b 05             	cmpl   $0x5,(%ebx)
     9b1:	77 1b                	ja     9ce <nulterminate+0x2e>
     9b3:	8b 03                	mov    (%ebx),%eax
     9b5:	ff 24 85 d0 12 00 00 	jmp    *0x12d0(,%eax,4)
     9bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(lcmd->right);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
     9c0:	83 ec 0c             	sub    $0xc,%esp
     9c3:	ff 73 04             	pushl  0x4(%ebx)
     9c6:	e8 d5 ff ff ff       	call   9a0 <nulterminate>
    break;
     9cb:	83 c4 10             	add    $0x10,%esp
  }
  return cmd;
}
     9ce:	89 d8                	mov    %ebx,%eax
     9d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     9d3:	c9                   	leave  
     9d4:	c3                   	ret    
     9d5:	8d 76 00             	lea    0x0(%esi),%esi
    nulterminate(lcmd->left);
     9d8:	83 ec 0c             	sub    $0xc,%esp
     9db:	ff 73 04             	pushl  0x4(%ebx)
     9de:	e8 bd ff ff ff       	call   9a0 <nulterminate>
    nulterminate(lcmd->right);
     9e3:	58                   	pop    %eax
     9e4:	ff 73 08             	pushl  0x8(%ebx)
     9e7:	e8 b4 ff ff ff       	call   9a0 <nulterminate>
}
     9ec:	89 d8                	mov    %ebx,%eax
    break;
     9ee:	83 c4 10             	add    $0x10,%esp
}
     9f1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     9f4:	c9                   	leave  
     9f5:	c3                   	ret    
     9f6:	8d 76 00             	lea    0x0(%esi),%esi
     9f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    for(i=0; ecmd->argv[i]; i++)
     a00:	8b 4b 04             	mov    0x4(%ebx),%ecx
     a03:	8d 43 08             	lea    0x8(%ebx),%eax
     a06:	85 c9                	test   %ecx,%ecx
     a08:	74 c4                	je     9ce <nulterminate+0x2e>
     a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     a10:	8b 50 24             	mov    0x24(%eax),%edx
     a13:	83 c0 04             	add    $0x4,%eax
     a16:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     a19:	8b 50 fc             	mov    -0x4(%eax),%edx
     a1c:	85 d2                	test   %edx,%edx
     a1e:	75 f0                	jne    a10 <nulterminate+0x70>
}
     a20:	89 d8                	mov    %ebx,%eax
     a22:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a25:	c9                   	leave  
     a26:	c3                   	ret    
     a27:	89 f6                	mov    %esi,%esi
     a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    nulterminate(rcmd->cmd);
     a30:	83 ec 0c             	sub    $0xc,%esp
     a33:	ff 73 04             	pushl  0x4(%ebx)
     a36:	e8 65 ff ff ff       	call   9a0 <nulterminate>
    *rcmd->efile = 0;
     a3b:	8b 43 0c             	mov    0xc(%ebx),%eax
    break;
     a3e:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     a41:	c6 00 00             	movb   $0x0,(%eax)
}
     a44:	89 d8                	mov    %ebx,%eax
     a46:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a49:	c9                   	leave  
     a4a:	c3                   	ret    
     a4b:	90                   	nop
     a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a50 <parsecmd>:
{
     a50:	55                   	push   %ebp
     a51:	89 e5                	mov    %esp,%ebp
     a53:	56                   	push   %esi
     a54:	53                   	push   %ebx
  es = s + strlen(s);
     a55:	8b 5d 08             	mov    0x8(%ebp),%ebx
     a58:	83 ec 0c             	sub    $0xc,%esp
     a5b:	53                   	push   %ebx
     a5c:	e8 df 00 00 00       	call   b40 <strlen>
  cmd = parseline(&s, es);
     a61:	59                   	pop    %ecx
  es = s + strlen(s);
     a62:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     a64:	8d 45 08             	lea    0x8(%ebp),%eax
     a67:	5e                   	pop    %esi
     a68:	53                   	push   %ebx
     a69:	50                   	push   %eax
     a6a:	e8 01 fe ff ff       	call   870 <parseline>
     a6f:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     a71:	8d 45 08             	lea    0x8(%ebp),%eax
     a74:	83 c4 0c             	add    $0xc,%esp
     a77:	68 19 12 00 00       	push   $0x1219
     a7c:	53                   	push   %ebx
     a7d:	50                   	push   %eax
     a7e:	e8 4d fb ff ff       	call   5d0 <peek>
  if(s != es){
     a83:	8b 45 08             	mov    0x8(%ebp),%eax
     a86:	83 c4 10             	add    $0x10,%esp
     a89:	39 c3                	cmp    %eax,%ebx
     a8b:	75 12                	jne    a9f <parsecmd+0x4f>
  nulterminate(cmd);
     a8d:	83 ec 0c             	sub    $0xc,%esp
     a90:	56                   	push   %esi
     a91:	e8 0a ff ff ff       	call   9a0 <nulterminate>
}
     a96:	8d 65 f8             	lea    -0x8(%ebp),%esp
     a99:	89 f0                	mov    %esi,%eax
     a9b:	5b                   	pop    %ebx
     a9c:	5e                   	pop    %esi
     a9d:	5d                   	pop    %ebp
     a9e:	c3                   	ret    
    printf(2, "leftovers: %s\n", s);
     a9f:	52                   	push   %edx
     aa0:	50                   	push   %eax
     aa1:	68 92 12 00 00       	push   $0x1292
     aa6:	6a 02                	push   $0x2
     aa8:	e8 c3 03 00 00       	call   e70 <printf>
    panic("syntax");
     aad:	c7 04 24 56 12 00 00 	movl   $0x1256,(%esp)
     ab4:	e8 a7 f6 ff ff       	call   160 <panic>
     ab9:	66 90                	xchg   %ax,%ax
     abb:	66 90                	xchg   %ax,%ax
     abd:	66 90                	xchg   %ax,%ax
     abf:	90                   	nop

00000ac0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     ac0:	55                   	push   %ebp
     ac1:	89 e5                	mov    %esp,%ebp
     ac3:	53                   	push   %ebx
     ac4:	8b 45 08             	mov    0x8(%ebp),%eax
     ac7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     aca:	89 c2                	mov    %eax,%edx
     acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ad0:	83 c1 01             	add    $0x1,%ecx
     ad3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     ad7:	83 c2 01             	add    $0x1,%edx
     ada:	84 db                	test   %bl,%bl
     adc:	88 5a ff             	mov    %bl,-0x1(%edx)
     adf:	75 ef                	jne    ad0 <strcpy+0x10>
    ;
  return os;
}
     ae1:	5b                   	pop    %ebx
     ae2:	5d                   	pop    %ebp
     ae3:	c3                   	ret    
     ae4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     aea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000af0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     af0:	55                   	push   %ebp
     af1:	89 e5                	mov    %esp,%ebp
     af3:	56                   	push   %esi
     af4:	53                   	push   %ebx
     af5:	8b 55 08             	mov    0x8(%ebp),%edx
     af8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     afb:	0f b6 02             	movzbl (%edx),%eax
     afe:	0f b6 19             	movzbl (%ecx),%ebx
     b01:	84 c0                	test   %al,%al
     b03:	75 1e                	jne    b23 <strcmp+0x33>
     b05:	eb 29                	jmp    b30 <strcmp+0x40>
     b07:	89 f6                	mov    %esi,%esi
     b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     b10:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
     b13:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
     b16:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
     b19:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
     b1d:	84 c0                	test   %al,%al
     b1f:	74 0f                	je     b30 <strcmp+0x40>
     b21:	89 f1                	mov    %esi,%ecx
     b23:	38 d8                	cmp    %bl,%al
     b25:	74 e9                	je     b10 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
     b27:	29 d8                	sub    %ebx,%eax
}
     b29:	5b                   	pop    %ebx
     b2a:	5e                   	pop    %esi
     b2b:	5d                   	pop    %ebp
     b2c:	c3                   	ret    
     b2d:	8d 76 00             	lea    0x0(%esi),%esi
  while(*p && *p == *q)
     b30:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     b32:	29 d8                	sub    %ebx,%eax
}
     b34:	5b                   	pop    %ebx
     b35:	5e                   	pop    %esi
     b36:	5d                   	pop    %ebp
     b37:	c3                   	ret    
     b38:	90                   	nop
     b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000b40 <strlen>:

uint
strlen(char *s)
{
     b40:	55                   	push   %ebp
     b41:	89 e5                	mov    %esp,%ebp
     b43:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     b46:	80 39 00             	cmpb   $0x0,(%ecx)
     b49:	74 12                	je     b5d <strlen+0x1d>
     b4b:	31 d2                	xor    %edx,%edx
     b4d:	8d 76 00             	lea    0x0(%esi),%esi
     b50:	83 c2 01             	add    $0x1,%edx
     b53:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     b57:	89 d0                	mov    %edx,%eax
     b59:	75 f5                	jne    b50 <strlen+0x10>
    ;
  return n;
}
     b5b:	5d                   	pop    %ebp
     b5c:	c3                   	ret    
  for(n = 0; s[n]; n++)
     b5d:	31 c0                	xor    %eax,%eax
}
     b5f:	5d                   	pop    %ebp
     b60:	c3                   	ret    
     b61:	eb 0d                	jmp    b70 <memset>
     b63:	90                   	nop
     b64:	90                   	nop
     b65:	90                   	nop
     b66:	90                   	nop
     b67:	90                   	nop
     b68:	90                   	nop
     b69:	90                   	nop
     b6a:	90                   	nop
     b6b:	90                   	nop
     b6c:	90                   	nop
     b6d:	90                   	nop
     b6e:	90                   	nop
     b6f:	90                   	nop

00000b70 <memset>:

void*
memset(void *dst, int c, uint n)
{
     b70:	55                   	push   %ebp
     b71:	89 e5                	mov    %esp,%ebp
     b73:	57                   	push   %edi
     b74:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     b77:	8b 4d 10             	mov    0x10(%ebp),%ecx
     b7a:	8b 45 0c             	mov    0xc(%ebp),%eax
     b7d:	89 d7                	mov    %edx,%edi
     b7f:	fc                   	cld    
     b80:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     b82:	89 d0                	mov    %edx,%eax
     b84:	5f                   	pop    %edi
     b85:	5d                   	pop    %ebp
     b86:	c3                   	ret    
     b87:	89 f6                	mov    %esi,%esi
     b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b90 <strchr>:

char*
strchr(const char *s, char c)
{
     b90:	55                   	push   %ebp
     b91:	89 e5                	mov    %esp,%ebp
     b93:	53                   	push   %ebx
     b94:	8b 45 08             	mov    0x8(%ebp),%eax
     b97:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
     b9a:	0f b6 10             	movzbl (%eax),%edx
     b9d:	84 d2                	test   %dl,%dl
     b9f:	74 1d                	je     bbe <strchr+0x2e>
    if(*s == c)
     ba1:	38 d3                	cmp    %dl,%bl
     ba3:	89 d9                	mov    %ebx,%ecx
     ba5:	75 0d                	jne    bb4 <strchr+0x24>
     ba7:	eb 17                	jmp    bc0 <strchr+0x30>
     ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     bb0:	38 ca                	cmp    %cl,%dl
     bb2:	74 0c                	je     bc0 <strchr+0x30>
  for(; *s; s++)
     bb4:	83 c0 01             	add    $0x1,%eax
     bb7:	0f b6 10             	movzbl (%eax),%edx
     bba:	84 d2                	test   %dl,%dl
     bbc:	75 f2                	jne    bb0 <strchr+0x20>
      return (char*)s;
  return 0;
     bbe:	31 c0                	xor    %eax,%eax
}
     bc0:	5b                   	pop    %ebx
     bc1:	5d                   	pop    %ebp
     bc2:	c3                   	ret    
     bc3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000bd0 <gets>:

char*
gets(char *buf, int max)
{
     bd0:	55                   	push   %ebp
     bd1:	89 e5                	mov    %esp,%ebp
     bd3:	57                   	push   %edi
     bd4:	56                   	push   %esi
     bd5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     bd6:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
     bd8:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
     bdb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
     bde:	eb 29                	jmp    c09 <gets+0x39>
    cc = read(0, &c, 1);
     be0:	83 ec 04             	sub    $0x4,%esp
     be3:	6a 01                	push   $0x1
     be5:	57                   	push   %edi
     be6:	6a 00                	push   $0x0
     be8:	e8 2d 01 00 00       	call   d1a <read>
    if(cc < 1)
     bed:	83 c4 10             	add    $0x10,%esp
     bf0:	85 c0                	test   %eax,%eax
     bf2:	7e 1d                	jle    c11 <gets+0x41>
      break;
    buf[i++] = c;
     bf4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     bf8:	8b 55 08             	mov    0x8(%ebp),%edx
     bfb:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
     bfd:	3c 0a                	cmp    $0xa,%al
    buf[i++] = c;
     bff:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
     c03:	74 1b                	je     c20 <gets+0x50>
     c05:	3c 0d                	cmp    $0xd,%al
     c07:	74 17                	je     c20 <gets+0x50>
  for(i=0; i+1 < max; ){
     c09:	8d 5e 01             	lea    0x1(%esi),%ebx
     c0c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     c0f:	7c cf                	jl     be0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
     c11:	8b 45 08             	mov    0x8(%ebp),%eax
     c14:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
     c18:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c1b:	5b                   	pop    %ebx
     c1c:	5e                   	pop    %esi
     c1d:	5f                   	pop    %edi
     c1e:	5d                   	pop    %ebp
     c1f:	c3                   	ret    
  buf[i] = '\0';
     c20:	8b 45 08             	mov    0x8(%ebp),%eax
  for(i=0; i+1 < max; ){
     c23:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
     c25:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
     c29:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c2c:	5b                   	pop    %ebx
     c2d:	5e                   	pop    %esi
     c2e:	5f                   	pop    %edi
     c2f:	5d                   	pop    %ebp
     c30:	c3                   	ret    
     c31:	eb 0d                	jmp    c40 <stat>
     c33:	90                   	nop
     c34:	90                   	nop
     c35:	90                   	nop
     c36:	90                   	nop
     c37:	90                   	nop
     c38:	90                   	nop
     c39:	90                   	nop
     c3a:	90                   	nop
     c3b:	90                   	nop
     c3c:	90                   	nop
     c3d:	90                   	nop
     c3e:	90                   	nop
     c3f:	90                   	nop

00000c40 <stat>:

int
stat(char *n, struct stat *st)
{
     c40:	55                   	push   %ebp
     c41:	89 e5                	mov    %esp,%ebp
     c43:	56                   	push   %esi
     c44:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     c45:	83 ec 08             	sub    $0x8,%esp
     c48:	6a 00                	push   $0x0
     c4a:	ff 75 08             	pushl  0x8(%ebp)
     c4d:	e8 f0 00 00 00       	call   d42 <open>
  if(fd < 0)
     c52:	83 c4 10             	add    $0x10,%esp
     c55:	85 c0                	test   %eax,%eax
     c57:	78 27                	js     c80 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     c59:	83 ec 08             	sub    $0x8,%esp
     c5c:	ff 75 0c             	pushl  0xc(%ebp)
     c5f:	89 c3                	mov    %eax,%ebx
     c61:	50                   	push   %eax
     c62:	e8 f3 00 00 00       	call   d5a <fstat>
  close(fd);
     c67:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     c6a:	89 c6                	mov    %eax,%esi
  close(fd);
     c6c:	e8 b9 00 00 00       	call   d2a <close>
  return r;
     c71:	83 c4 10             	add    $0x10,%esp
}
     c74:	8d 65 f8             	lea    -0x8(%ebp),%esp
     c77:	89 f0                	mov    %esi,%eax
     c79:	5b                   	pop    %ebx
     c7a:	5e                   	pop    %esi
     c7b:	5d                   	pop    %ebp
     c7c:	c3                   	ret    
     c7d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     c80:	be ff ff ff ff       	mov    $0xffffffff,%esi
     c85:	eb ed                	jmp    c74 <stat+0x34>
     c87:	89 f6                	mov    %esi,%esi
     c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c90 <atoi>:

int
atoi(const char *s)
{
     c90:	55                   	push   %ebp
     c91:	89 e5                	mov    %esp,%ebp
     c93:	53                   	push   %ebx
     c94:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     c97:	0f be 11             	movsbl (%ecx),%edx
     c9a:	8d 42 d0             	lea    -0x30(%edx),%eax
     c9d:	3c 09                	cmp    $0x9,%al
     c9f:	b8 00 00 00 00       	mov    $0x0,%eax
     ca4:	77 1f                	ja     cc5 <atoi+0x35>
     ca6:	8d 76 00             	lea    0x0(%esi),%esi
     ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
     cb0:	8d 04 80             	lea    (%eax,%eax,4),%eax
     cb3:	83 c1 01             	add    $0x1,%ecx
     cb6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
     cba:	0f be 11             	movsbl (%ecx),%edx
     cbd:	8d 5a d0             	lea    -0x30(%edx),%ebx
     cc0:	80 fb 09             	cmp    $0x9,%bl
     cc3:	76 eb                	jbe    cb0 <atoi+0x20>
  return n;
}
     cc5:	5b                   	pop    %ebx
     cc6:	5d                   	pop    %ebp
     cc7:	c3                   	ret    
     cc8:	90                   	nop
     cc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000cd0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     cd0:	55                   	push   %ebp
     cd1:	89 e5                	mov    %esp,%ebp
     cd3:	56                   	push   %esi
     cd4:	53                   	push   %ebx
     cd5:	8b 5d 10             	mov    0x10(%ebp),%ebx
     cd8:	8b 45 08             	mov    0x8(%ebp),%eax
     cdb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     cde:	85 db                	test   %ebx,%ebx
     ce0:	7e 14                	jle    cf6 <memmove+0x26>
     ce2:	31 d2                	xor    %edx,%edx
     ce4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
     ce8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     cec:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     cef:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
     cf2:	39 da                	cmp    %ebx,%edx
     cf4:	75 f2                	jne    ce8 <memmove+0x18>
  return vdst;
}
     cf6:	5b                   	pop    %ebx
     cf7:	5e                   	pop    %esi
     cf8:	5d                   	pop    %ebp
     cf9:	c3                   	ret    

00000cfa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     cfa:	b8 01 00 00 00       	mov    $0x1,%eax
     cff:	cd 40                	int    $0x40
     d01:	c3                   	ret    

00000d02 <exit>:
SYSCALL(exit)
     d02:	b8 02 00 00 00       	mov    $0x2,%eax
     d07:	cd 40                	int    $0x40
     d09:	c3                   	ret    

00000d0a <wait>:
SYSCALL(wait)
     d0a:	b8 03 00 00 00       	mov    $0x3,%eax
     d0f:	cd 40                	int    $0x40
     d11:	c3                   	ret    

00000d12 <pipe>:
SYSCALL(pipe)
     d12:	b8 04 00 00 00       	mov    $0x4,%eax
     d17:	cd 40                	int    $0x40
     d19:	c3                   	ret    

00000d1a <read>:
SYSCALL(read)
     d1a:	b8 05 00 00 00       	mov    $0x5,%eax
     d1f:	cd 40                	int    $0x40
     d21:	c3                   	ret    

00000d22 <write>:
SYSCALL(write)
     d22:	b8 10 00 00 00       	mov    $0x10,%eax
     d27:	cd 40                	int    $0x40
     d29:	c3                   	ret    

00000d2a <close>:
SYSCALL(close)
     d2a:	b8 15 00 00 00       	mov    $0x15,%eax
     d2f:	cd 40                	int    $0x40
     d31:	c3                   	ret    

00000d32 <kill>:
SYSCALL(kill)
     d32:	b8 06 00 00 00       	mov    $0x6,%eax
     d37:	cd 40                	int    $0x40
     d39:	c3                   	ret    

00000d3a <exec>:
SYSCALL(exec)
     d3a:	b8 07 00 00 00       	mov    $0x7,%eax
     d3f:	cd 40                	int    $0x40
     d41:	c3                   	ret    

00000d42 <open>:
SYSCALL(open)
     d42:	b8 0f 00 00 00       	mov    $0xf,%eax
     d47:	cd 40                	int    $0x40
     d49:	c3                   	ret    

00000d4a <mknod>:
SYSCALL(mknod)
     d4a:	b8 11 00 00 00       	mov    $0x11,%eax
     d4f:	cd 40                	int    $0x40
     d51:	c3                   	ret    

00000d52 <unlink>:
SYSCALL(unlink)
     d52:	b8 12 00 00 00       	mov    $0x12,%eax
     d57:	cd 40                	int    $0x40
     d59:	c3                   	ret    

00000d5a <fstat>:
SYSCALL(fstat)
     d5a:	b8 08 00 00 00       	mov    $0x8,%eax
     d5f:	cd 40                	int    $0x40
     d61:	c3                   	ret    

00000d62 <link>:
SYSCALL(link)
     d62:	b8 13 00 00 00       	mov    $0x13,%eax
     d67:	cd 40                	int    $0x40
     d69:	c3                   	ret    

00000d6a <mkdir>:
SYSCALL(mkdir)
     d6a:	b8 14 00 00 00       	mov    $0x14,%eax
     d6f:	cd 40                	int    $0x40
     d71:	c3                   	ret    

00000d72 <chdir>:
SYSCALL(chdir)
     d72:	b8 09 00 00 00       	mov    $0x9,%eax
     d77:	cd 40                	int    $0x40
     d79:	c3                   	ret    

00000d7a <dup>:
SYSCALL(dup)
     d7a:	b8 0a 00 00 00       	mov    $0xa,%eax
     d7f:	cd 40                	int    $0x40
     d81:	c3                   	ret    

00000d82 <getpid>:
SYSCALL(getpid)
     d82:	b8 0b 00 00 00       	mov    $0xb,%eax
     d87:	cd 40                	int    $0x40
     d89:	c3                   	ret    

00000d8a <sbrk>:
SYSCALL(sbrk)
     d8a:	b8 0c 00 00 00       	mov    $0xc,%eax
     d8f:	cd 40                	int    $0x40
     d91:	c3                   	ret    

00000d92 <sleep>:
SYSCALL(sleep)
     d92:	b8 0d 00 00 00       	mov    $0xd,%eax
     d97:	cd 40                	int    $0x40
     d99:	c3                   	ret    

00000d9a <uptime>:
SYSCALL(uptime)
     d9a:	b8 0e 00 00 00       	mov    $0xe,%eax
     d9f:	cd 40                	int    $0x40
     da1:	c3                   	ret    

00000da2 <dup2>:
SYSCALL(dup2)
     da2:	b8 16 00 00 00       	mov    $0x16,%eax
     da7:	cd 40                	int    $0x40
     da9:	c3                   	ret    

00000daa <getcwd>:
SYSCALL(getcwd)
     daa:	b8 17 00 00 00       	mov    $0x17,%eax
     daf:	cd 40                	int    $0x40
     db1:	c3                   	ret    

00000db2 <getmz>:
SYSCALL(getmz)
     db2:	b8 18 00 00 00       	mov    $0x18,%eax
     db7:	cd 40                	int    $0x40
     db9:	c3                   	ret    

00000dba <jared>:
SYSCALL(jared)
     dba:	b8 19 00 00 00       	mov    $0x19,%eax
     dbf:	cd 40                	int    $0x40
     dc1:	c3                   	ret    
     dc2:	66 90                	xchg   %ax,%ax
     dc4:	66 90                	xchg   %ax,%ax
     dc6:	66 90                	xchg   %ax,%ax
     dc8:	66 90                	xchg   %ax,%ax
     dca:	66 90                	xchg   %ax,%ax
     dcc:	66 90                	xchg   %ax,%ax
     dce:	66 90                	xchg   %ax,%ax

00000dd0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     dd0:	55                   	push   %ebp
     dd1:	89 e5                	mov    %esp,%ebp
     dd3:	57                   	push   %edi
     dd4:	56                   	push   %esi
     dd5:	53                   	push   %ebx
     dd6:	89 c6                	mov    %eax,%esi
     dd8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     ddb:	8b 5d 08             	mov    0x8(%ebp),%ebx
     dde:	85 db                	test   %ebx,%ebx
     de0:	74 7e                	je     e60 <printint+0x90>
     de2:	89 d0                	mov    %edx,%eax
     de4:	c1 e8 1f             	shr    $0x1f,%eax
     de7:	84 c0                	test   %al,%al
     de9:	74 75                	je     e60 <printint+0x90>
    neg = 1;
    x = -xx;
     deb:	89 d0                	mov    %edx,%eax
    neg = 1;
     ded:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
     df4:	f7 d8                	neg    %eax
     df6:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
     df9:	31 ff                	xor    %edi,%edi
     dfb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
     dfe:	89 ce                	mov    %ecx,%esi
     e00:	eb 08                	jmp    e0a <printint+0x3a>
     e02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
     e08:	89 cf                	mov    %ecx,%edi
     e0a:	31 d2                	xor    %edx,%edx
     e0c:	8d 4f 01             	lea    0x1(%edi),%ecx
     e0f:	f7 f6                	div    %esi
     e11:	0f b6 92 f0 12 00 00 	movzbl 0x12f0(%edx),%edx
  }while((x /= base) != 0);
     e18:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
     e1a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
     e1d:	75 e9                	jne    e08 <printint+0x38>
  if(neg)
     e1f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     e22:	8b 75 c0             	mov    -0x40(%ebp),%esi
     e25:	85 c0                	test   %eax,%eax
     e27:	74 08                	je     e31 <printint+0x61>
    buf[i++] = '-';
     e29:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
     e2e:	8d 4f 02             	lea    0x2(%edi),%ecx

  while(--i >= 0)
     e31:	8d 79 ff             	lea    -0x1(%ecx),%edi
     e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e38:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
  write(fd, &c, 1);
     e3d:	83 ec 04             	sub    $0x4,%esp
  while(--i >= 0)
     e40:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
     e43:	6a 01                	push   $0x1
     e45:	53                   	push   %ebx
     e46:	56                   	push   %esi
     e47:	88 45 d7             	mov    %al,-0x29(%ebp)
     e4a:	e8 d3 fe ff ff       	call   d22 <write>
  while(--i >= 0)
     e4f:	83 c4 10             	add    $0x10,%esp
     e52:	83 ff ff             	cmp    $0xffffffff,%edi
     e55:	75 e1                	jne    e38 <printint+0x68>
    putc(fd, buf[i]);
}
     e57:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e5a:	5b                   	pop    %ebx
     e5b:	5e                   	pop    %esi
     e5c:	5f                   	pop    %edi
     e5d:	5d                   	pop    %ebp
     e5e:	c3                   	ret    
     e5f:	90                   	nop
    x = xx;
     e60:	89 d0                	mov    %edx,%eax
  neg = 0;
     e62:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
     e69:	eb 8b                	jmp    df6 <printint+0x26>
     e6b:	90                   	nop
     e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000e70 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     e70:	55                   	push   %ebp
     e71:	89 e5                	mov    %esp,%ebp
     e73:	57                   	push   %edi
     e74:	56                   	push   %esi
     e75:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     e76:	8d 45 10             	lea    0x10(%ebp),%eax
{
     e79:	83 ec 2c             	sub    $0x2c,%esp
  for(i = 0; fmt[i]; i++){
     e7c:	8b 75 0c             	mov    0xc(%ebp),%esi
{
     e7f:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
     e82:	89 45 d0             	mov    %eax,-0x30(%ebp)
     e85:	0f b6 1e             	movzbl (%esi),%ebx
     e88:	83 c6 01             	add    $0x1,%esi
     e8b:	84 db                	test   %bl,%bl
     e8d:	0f 84 b0 00 00 00    	je     f43 <printf+0xd3>
     e93:	31 d2                	xor    %edx,%edx
     e95:	eb 39                	jmp    ed0 <printf+0x60>
     e97:	89 f6                	mov    %esi,%esi
     e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     ea0:	83 f8 25             	cmp    $0x25,%eax
     ea3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
     ea6:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
     eab:	74 18                	je     ec5 <printf+0x55>
  write(fd, &c, 1);
     ead:	8d 45 e2             	lea    -0x1e(%ebp),%eax
     eb0:	83 ec 04             	sub    $0x4,%esp
     eb3:	88 5d e2             	mov    %bl,-0x1e(%ebp)
     eb6:	6a 01                	push   $0x1
     eb8:	50                   	push   %eax
     eb9:	57                   	push   %edi
     eba:	e8 63 fe ff ff       	call   d22 <write>
     ebf:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     ec2:	83 c4 10             	add    $0x10,%esp
     ec5:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
     ec8:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
     ecc:	84 db                	test   %bl,%bl
     ece:	74 73                	je     f43 <printf+0xd3>
    if(state == 0){
     ed0:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
     ed2:	0f be cb             	movsbl %bl,%ecx
     ed5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
     ed8:	74 c6                	je     ea0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     eda:	83 fa 25             	cmp    $0x25,%edx
     edd:	75 e6                	jne    ec5 <printf+0x55>
      if(c == 'd'){
     edf:	83 f8 64             	cmp    $0x64,%eax
     ee2:	0f 84 f8 00 00 00    	je     fe0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
     ee8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
     eee:	83 f9 70             	cmp    $0x70,%ecx
     ef1:	74 5d                	je     f50 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
     ef3:	83 f8 73             	cmp    $0x73,%eax
     ef6:	0f 84 84 00 00 00    	je     f80 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     efc:	83 f8 63             	cmp    $0x63,%eax
     eff:	0f 84 ea 00 00 00    	je     fef <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
     f05:	83 f8 25             	cmp    $0x25,%eax
     f08:	0f 84 c2 00 00 00    	je     fd0 <printf+0x160>
  write(fd, &c, 1);
     f0e:	8d 45 e7             	lea    -0x19(%ebp),%eax
     f11:	83 ec 04             	sub    $0x4,%esp
     f14:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
     f18:	6a 01                	push   $0x1
     f1a:	50                   	push   %eax
     f1b:	57                   	push   %edi
     f1c:	e8 01 fe ff ff       	call   d22 <write>
     f21:	83 c4 0c             	add    $0xc,%esp
     f24:	8d 45 e6             	lea    -0x1a(%ebp),%eax
     f27:	88 5d e6             	mov    %bl,-0x1a(%ebp)
     f2a:	6a 01                	push   $0x1
     f2c:	50                   	push   %eax
     f2d:	57                   	push   %edi
     f2e:	83 c6 01             	add    $0x1,%esi
     f31:	e8 ec fd ff ff       	call   d22 <write>
  for(i = 0; fmt[i]; i++){
     f36:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
     f3a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     f3d:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
     f3f:	84 db                	test   %bl,%bl
     f41:	75 8d                	jne    ed0 <printf+0x60>
    }
  }
}
     f43:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f46:	5b                   	pop    %ebx
     f47:	5e                   	pop    %esi
     f48:	5f                   	pop    %edi
     f49:	5d                   	pop    %ebp
     f4a:	c3                   	ret    
     f4b:	90                   	nop
     f4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 16, 0);
     f50:	83 ec 0c             	sub    $0xc,%esp
     f53:	b9 10 00 00 00       	mov    $0x10,%ecx
     f58:	6a 00                	push   $0x0
     f5a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
     f5d:	89 f8                	mov    %edi,%eax
     f5f:	8b 13                	mov    (%ebx),%edx
     f61:	e8 6a fe ff ff       	call   dd0 <printint>
        ap++;
     f66:	89 d8                	mov    %ebx,%eax
     f68:	83 c4 10             	add    $0x10,%esp
      state = 0;
     f6b:	31 d2                	xor    %edx,%edx
        ap++;
     f6d:	83 c0 04             	add    $0x4,%eax
     f70:	89 45 d0             	mov    %eax,-0x30(%ebp)
     f73:	e9 4d ff ff ff       	jmp    ec5 <printf+0x55>
     f78:	90                   	nop
     f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
     f80:	8b 45 d0             	mov    -0x30(%ebp),%eax
     f83:	8b 18                	mov    (%eax),%ebx
        ap++;
     f85:	83 c0 04             	add    $0x4,%eax
     f88:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
     f8b:	85 db                	test   %ebx,%ebx
     f8d:	74 7c                	je     100b <printf+0x19b>
        while(*s != 0){
     f8f:	0f b6 03             	movzbl (%ebx),%eax
     f92:	84 c0                	test   %al,%al
     f94:	74 29                	je     fbf <printf+0x14f>
     f96:	8d 76 00             	lea    0x0(%esi),%esi
     f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     fa0:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
     fa3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
     fa6:	83 ec 04             	sub    $0x4,%esp
     fa9:	6a 01                	push   $0x1
          s++;
     fab:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
     fae:	50                   	push   %eax
     faf:	57                   	push   %edi
     fb0:	e8 6d fd ff ff       	call   d22 <write>
        while(*s != 0){
     fb5:	0f b6 03             	movzbl (%ebx),%eax
     fb8:	83 c4 10             	add    $0x10,%esp
     fbb:	84 c0                	test   %al,%al
     fbd:	75 e1                	jne    fa0 <printf+0x130>
      state = 0;
     fbf:	31 d2                	xor    %edx,%edx
     fc1:	e9 ff fe ff ff       	jmp    ec5 <printf+0x55>
     fc6:	8d 76 00             	lea    0x0(%esi),%esi
     fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  write(fd, &c, 1);
     fd0:	83 ec 04             	sub    $0x4,%esp
     fd3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
     fd6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
     fd9:	6a 01                	push   $0x1
     fdb:	e9 4c ff ff ff       	jmp    f2c <printf+0xbc>
        printint(fd, *ap, 10, 1);
     fe0:	83 ec 0c             	sub    $0xc,%esp
     fe3:	b9 0a 00 00 00       	mov    $0xa,%ecx
     fe8:	6a 01                	push   $0x1
     fea:	e9 6b ff ff ff       	jmp    f5a <printf+0xea>
        putc(fd, *ap);
     fef:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
     ff2:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
     ff5:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
     ff7:	6a 01                	push   $0x1
        putc(fd, *ap);
     ff9:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
     ffc:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     fff:	50                   	push   %eax
    1000:	57                   	push   %edi
    1001:	e8 1c fd ff ff       	call   d22 <write>
    1006:	e9 5b ff ff ff       	jmp    f66 <printf+0xf6>
        while(*s != 0){
    100b:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
    1010:	bb e8 12 00 00       	mov    $0x12e8,%ebx
    1015:	eb 89                	jmp    fa0 <printf+0x130>
    1017:	66 90                	xchg   %ax,%ax
    1019:	66 90                	xchg   %ax,%ax
    101b:	66 90                	xchg   %ax,%ax
    101d:	66 90                	xchg   %ax,%ax
    101f:	90                   	nop

00001020 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1020:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1021:	a1 84 19 00 00       	mov    0x1984,%eax
{
    1026:	89 e5                	mov    %esp,%ebp
    1028:	57                   	push   %edi
    1029:	56                   	push   %esi
    102a:	53                   	push   %ebx
    102b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    102e:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
    1030:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1033:	39 c8                	cmp    %ecx,%eax
    1035:	73 19                	jae    1050 <free+0x30>
    1037:	89 f6                	mov    %esi,%esi
    1039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    1040:	39 d1                	cmp    %edx,%ecx
    1042:	72 1c                	jb     1060 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1044:	39 d0                	cmp    %edx,%eax
    1046:	73 18                	jae    1060 <free+0x40>
{
    1048:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    104a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    104c:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    104e:	72 f0                	jb     1040 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1050:	39 d0                	cmp    %edx,%eax
    1052:	72 f4                	jb     1048 <free+0x28>
    1054:	39 d1                	cmp    %edx,%ecx
    1056:	73 f0                	jae    1048 <free+0x28>
    1058:	90                   	nop
    1059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
    1060:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1063:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1066:	39 fa                	cmp    %edi,%edx
    1068:	74 19                	je     1083 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    106a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    106d:	8b 50 04             	mov    0x4(%eax),%edx
    1070:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1073:	39 f1                	cmp    %esi,%ecx
    1075:	74 23                	je     109a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1077:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1079:	a3 84 19 00 00       	mov    %eax,0x1984
}
    107e:	5b                   	pop    %ebx
    107f:	5e                   	pop    %esi
    1080:	5f                   	pop    %edi
    1081:	5d                   	pop    %ebp
    1082:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    1083:	03 72 04             	add    0x4(%edx),%esi
    1086:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1089:	8b 10                	mov    (%eax),%edx
    108b:	8b 12                	mov    (%edx),%edx
    108d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1090:	8b 50 04             	mov    0x4(%eax),%edx
    1093:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1096:	39 f1                	cmp    %esi,%ecx
    1098:	75 dd                	jne    1077 <free+0x57>
    p->s.size += bp->s.size;
    109a:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    109d:	a3 84 19 00 00       	mov    %eax,0x1984
    p->s.size += bp->s.size;
    10a2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    10a5:	8b 53 f8             	mov    -0x8(%ebx),%edx
    10a8:	89 10                	mov    %edx,(%eax)
}
    10aa:	5b                   	pop    %ebx
    10ab:	5e                   	pop    %esi
    10ac:	5f                   	pop    %edi
    10ad:	5d                   	pop    %ebp
    10ae:	c3                   	ret    
    10af:	90                   	nop

000010b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    10b0:	55                   	push   %ebp
    10b1:	89 e5                	mov    %esp,%ebp
    10b3:	57                   	push   %edi
    10b4:	56                   	push   %esi
    10b5:	53                   	push   %ebx
    10b6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    10b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    10bc:	8b 15 84 19 00 00    	mov    0x1984,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    10c2:	8d 78 07             	lea    0x7(%eax),%edi
    10c5:	c1 ef 03             	shr    $0x3,%edi
    10c8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    10cb:	85 d2                	test   %edx,%edx
    10cd:	0f 84 93 00 00 00    	je     1166 <malloc+0xb6>
    10d3:	8b 02                	mov    (%edx),%eax
    10d5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    10d8:	39 cf                	cmp    %ecx,%edi
    10da:	76 64                	jbe    1140 <malloc+0x90>
    10dc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    10e2:	bb 00 10 00 00       	mov    $0x1000,%ebx
    10e7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    10ea:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    10f1:	eb 0e                	jmp    1101 <malloc+0x51>
    10f3:	90                   	nop
    10f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    10f8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    10fa:	8b 48 04             	mov    0x4(%eax),%ecx
    10fd:	39 cf                	cmp    %ecx,%edi
    10ff:	76 3f                	jbe    1140 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1101:	39 05 84 19 00 00    	cmp    %eax,0x1984
    1107:	89 c2                	mov    %eax,%edx
    1109:	75 ed                	jne    10f8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    110b:	83 ec 0c             	sub    $0xc,%esp
    110e:	56                   	push   %esi
    110f:	e8 76 fc ff ff       	call   d8a <sbrk>
  if(p == (char*)-1)
    1114:	83 c4 10             	add    $0x10,%esp
    1117:	83 f8 ff             	cmp    $0xffffffff,%eax
    111a:	74 1c                	je     1138 <malloc+0x88>
  hp->s.size = nu;
    111c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    111f:	83 ec 0c             	sub    $0xc,%esp
    1122:	83 c0 08             	add    $0x8,%eax
    1125:	50                   	push   %eax
    1126:	e8 f5 fe ff ff       	call   1020 <free>
  return freep;
    112b:	8b 15 84 19 00 00    	mov    0x1984,%edx
      if((p = morecore(nunits)) == 0)
    1131:	83 c4 10             	add    $0x10,%esp
    1134:	85 d2                	test   %edx,%edx
    1136:	75 c0                	jne    10f8 <malloc+0x48>
        return 0;
    1138:	31 c0                	xor    %eax,%eax
    113a:	eb 1c                	jmp    1158 <malloc+0xa8>
    113c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    1140:	39 cf                	cmp    %ecx,%edi
    1142:	74 1c                	je     1160 <malloc+0xb0>
        p->s.size -= nunits;
    1144:	29 f9                	sub    %edi,%ecx
    1146:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1149:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    114c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    114f:	89 15 84 19 00 00    	mov    %edx,0x1984
      return (void*)(p + 1);
    1155:	83 c0 08             	add    $0x8,%eax
  }
}
    1158:	8d 65 f4             	lea    -0xc(%ebp),%esp
    115b:	5b                   	pop    %ebx
    115c:	5e                   	pop    %esi
    115d:	5f                   	pop    %edi
    115e:	5d                   	pop    %ebp
    115f:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    1160:	8b 08                	mov    (%eax),%ecx
    1162:	89 0a                	mov    %ecx,(%edx)
    1164:	eb e9                	jmp    114f <malloc+0x9f>
    base.s.ptr = freep = prevp = &base;
    1166:	c7 05 84 19 00 00 88 	movl   $0x1988,0x1984
    116d:	19 00 00 
    1170:	c7 05 88 19 00 00 88 	movl   $0x1988,0x1988
    1177:	19 00 00 
    base.s.size = 0;
    117a:	b8 88 19 00 00       	mov    $0x1988,%eax
    117f:	c7 05 8c 19 00 00 00 	movl   $0x0,0x198c
    1186:	00 00 00 
    1189:	e9 4e ff ff ff       	jmp    10dc <malloc+0x2c>
    118e:	66 90                	xchg   %ax,%ax

00001190 <calloc>:

void*
calloc(uint nmemb, uint sz)
{
    1190:	55                   	push   %ebp
    1191:	89 e5                	mov    %esp,%ebp
    1193:	56                   	push   %esi
    1194:	53                   	push   %ebx
  uint full_sz = 0;
  if (__builtin_mul_overflow(nmemb, sz, &full_sz))
    1195:	8b 45 08             	mov    0x8(%ebp),%eax
    1198:	f7 65 0c             	mull   0xc(%ebp)
    119b:	70 25                	jo     11c2 <calloc+0x32>
    return NULL;
  void *region = malloc(full_sz);
    119d:	83 ec 0c             	sub    $0xc,%esp
    11a0:	89 c3                	mov    %eax,%ebx
    11a2:	50                   	push   %eax
    11a3:	e8 08 ff ff ff       	call   10b0 <malloc>
  memset(region, 0, full_sz);
    11a8:	83 c4 0c             	add    $0xc,%esp
  void *region = malloc(full_sz);
    11ab:	89 c6                	mov    %eax,%esi
  memset(region, 0, full_sz);
    11ad:	53                   	push   %ebx
    11ae:	6a 00                	push   $0x0
    11b0:	50                   	push   %eax
    11b1:	e8 ba f9 ff ff       	call   b70 <memset>
  return region;
    11b6:	83 c4 10             	add    $0x10,%esp
}
    11b9:	8d 65 f8             	lea    -0x8(%ebp),%esp
    11bc:	89 f0                	mov    %esi,%eax
    11be:	5b                   	pop    %ebx
    11bf:	5e                   	pop    %esi
    11c0:	5d                   	pop    %ebp
    11c1:	c3                   	ret    
    return NULL;
    11c2:	31 f6                	xor    %esi,%esi
    11c4:	eb f3                	jmp    11b9 <calloc+0x29>
    11c6:	8d 76 00             	lea    0x0(%esi),%esi
    11c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000011d0 <strdup>:

char*
strdup(char *s)
{
    11d0:	55                   	push   %ebp
    11d1:	89 e5                	mov    %esp,%ebp
    11d3:	56                   	push   %esi
    11d4:	53                   	push   %ebx
    11d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *buf = malloc(strlen(s) + 1);
    11d8:	83 ec 0c             	sub    $0xc,%esp
    11db:	53                   	push   %ebx
    11dc:	e8 5f f9 ff ff       	call   b40 <strlen>
    11e1:	83 c0 01             	add    $0x1,%eax
    11e4:	89 04 24             	mov    %eax,(%esp)
    11e7:	e8 c4 fe ff ff       	call   10b0 <malloc>
    11ec:	89 c6                	mov    %eax,%esi
  strcpy(buf, s);
    11ee:	58                   	pop    %eax
    11ef:	5a                   	pop    %edx
    11f0:	53                   	push   %ebx
    11f1:	56                   	push   %esi
    11f2:	e8 c9 f8 ff ff       	call   ac0 <strcpy>
  return buf;
}
    11f7:	8d 65 f8             	lea    -0x8(%ebp),%esp
    11fa:	89 f0                	mov    %esi,%eax
    11fc:	5b                   	pop    %ebx
    11fd:	5e                   	pop    %esi
    11fe:	5d                   	pop    %ebp
    11ff:	c3                   	ret    
