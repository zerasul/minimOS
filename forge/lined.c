/* line editor for minimOS!
 * v0.5a1
 * (c)2016 Carlos J. Santisteban
 * last modified 20160429-0945 */
 
#include <stdio.h>

#define	ctl_g	'\a'
#define	ctl_e	'\t'
#define	ctl_x	'\b'
#define	cr		'\n'
#define	down	'S'
#define	up		'W'
#define	FALSE	0
#define	TRUE	-1


typedef unsigned char b8;

b8	ram[65536]={"Hola\nMundo\n\0"};
b8	a, x, y;
b8	buffer[256];
b8	key, edit;
int cur, ptr, optr, src, dest, delta, top;

void prev() {
	printf("(PREV)\n");
	b8	c;
	
	if (ptr>0) {
		ptr--;
		c = ram[ptr];
		while (c!='\n' && c!='\0' && ptr>0) {
			ptr--;
		}
	}
}

void pop() {		//copy line into buffer
	printf("(POP)\n");
	int	i=0;
	b8	c;
	
	c=ram[ptr+i];
	while (c!='\0' && c!='\n') {
		buffer[i]=c;
		i++;
		c=ram[ptr+i];
	}
	buffer[i] = '\0';
}

void prompt() {
	printf("(PROMPT)\n");
	int	i=0;
	b8	c;
	
	printf("%04x>", cur);
	c = buffer[i];
	while (c!='\n' && c!='\0') {
		putchar(c);
		c = buffer[++i];
	}
}

void move_dn(int s, int d) {
	printf("MOVE_DN %d -> %d\n", s, d);
	
}

void move_up(int s, int d) {
	printf("MOVE_UP %d -> %d\n", s, d);
	
}

b8 buflen() {
	printf("(BUFLEN)\n");
	int	i=0;
	
	while(buffer[i]!='\0') {
		i++;
	}
	
	return i;
}

void push() {		//copy buffer @ptr
	printf("(PUSH)\n");
	int	i=0;
	b8	c;
	
	while ((c=buffer[i]) != '\0') {
		ram[ptr+i]=c;
		i++;
	}
	ram[ptr+i] = '\n';
}

void indent() {
	printf("(INDENT)\n");
	
	b8	c;
	int	i=0;
	
	if (ram[ptr]) {		// not the end
		ptr++;
		c = ram[ptr];
		while (c==' ' || c=='\t') {
			buffer[i++]=c;
			ptr++;
			c = ram[ptr];
		}
	}
	buffer[i]='\0';
}

void next() {
	printf("(NEXT)\n");
	
	b8	c;
	
	if (ptr<top) {
		ptr++;
		c = ram[ptr];
		while (c!='\n' && c!='\0' && ptr>0) {
			ptr++;
		}
	}
}

void show() {			//print cur: and line @ptr, advance ptr! otherwise next()
	printf("(SHOW)\n");
	b8	c;
	
	printf("%04x:", cur);
	c = ram[ptr];
	while (c!='\n' && c!='\0') {
		putchar(c);
		ptr++;
		c = ram[ptr];
	}
	printf("\n");
}

int ask() {
	int i;
	
	printf("Line: ");
	scanf("%d", &i);
	
	return i;
}

b8 valid(b8 k) {
	printf("(VALID %c)\n", k);
	if (k=='\t' || ('a'<=k && k<='z') || ('A'<=k && k<='Z') || ('0'<=k && k<='9'))
		return TRUE;
	else
		return FALSE;
}

int main(void)
{
	cur = 0;
	top = 0;
	ptr = 0;
	ram[ptr]='\0';
	buffer[0]=' ';
	buffer[1]='\0';
	
	edit=FALSE;
	pop();
	prompt();
	do {
		key = getchar_unlocked();			//read key
		if (key==ctl_e) {			//***edit previous***
			if (cur>0)		cur--;
			edit=TRUE;					//mode: edit existing
			prev();						//go back until CR or begin
			pop();						//copy line into buffer
			prompt();					//print cur> and buffer contents
		}
		if (key==ctl_x) {			//***delete previous***
			if (cur>0) {				//none if empty
				src=ptr;					//start of current line
				prev();						//back to previous
				move_dn(src,ptr);			//displace
				cur--;
			}
		}
		if (key==cr) {				//***insert or accept current***
			x=0;
			if (!edit) {				//*insert new line*
				src=ptr;					//current is kept
				dest=ptr+buflen()		;	//room for buffer
				move_up(src,dest);
			} else {					//*replace old*
				edit=FALSE;
				optr=ptr;					//save current pos
				next();						//set ptr to next line (advance current size)
				delta=optr+buflen()-ptr;	//new vs old length
				if (delta>0) {				//now is longer
					move_up(optr,optr+delta);	//get extra room
				} else if (delta<0) { 		//now is shorter
					move_dn(optr+delta,optr);	//shrink
				}							//don't move if same length
				ptr=optr;					//retrieve
			}
			push();						//copy buffer @ptr
			indent();					//copy leading whitespace into buffer and terminate it
			next();						//point to next
			cur++;
			prompt();					//show cur> and buffer (indent)
		}
		if (key==up && cur>1) {		//***show previous***
			cur-=2;
			prev();
			//this should be common
			indent();					//get leading whitespace
			show();						//print cur: and line @ptr, advance ptr! otherwise next()
			cur++;
			prompt();					//show new cur> and buffer (indent)
		}
		if (key==down && ram[ptr]) {	//***show next if not at end***
			//common as above
			indent();					//get leading whitespace
			show();						//print cur: and line @ptr, advance ptr! otherwise next()
			cur++;
			prompt();					//show new cur> and buffer (indent)
		}
		//should do start & end keys
		//what to do on ESC? common block?
		if (key==ctl_g) {			//***goto line***
			dest=ask();					//prompt for line number
			ptr=0;						//eeeeeeek!
			for(cur=0;cur<dest;cur++) {
				optr=ptr;					//keep old pos
				next();						//advance one line
				if (!ram[ptr])	break;		//abort at end
			}
			ptr=optr;					//back once, should decr. cur???
			//common as above
		}
		if (valid(key)) {			//***including tabs shown raw***
			//edit like READLN in raw
			//don't manage CR/ESC
			putchar(key);
			buffer[x++]=key;
		}
	} while(-1);				// loop forever
	
	return 0;
}
