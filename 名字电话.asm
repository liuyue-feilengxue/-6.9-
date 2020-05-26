;author:六月飞冷雪
;沈美明版汇编教材，课后6.9代码
DATAS SEGMENT
    ;此处输入数据段代码 
    inbuf db 20 dup(?)
    outname db 20 dup(?),'$'
    outphone db 8 dup(?),'$';防乱码
    
    STR1 db "input name:$"
    STR2 db "input telephone number:$"
    STR3 db "PHONE NUMBER LESS THAN 8$"
    STR4 db "INPUT IS NOT NUMBER$"
    tabletitle db 'NAME',16 dup(20h),'TEL.',13,10,'$'
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
main proc far
    ASSUME CS:CODES,DS:DATAS,SS:STACKS

    MOV AX,DATAS
    MOV DS,AX
    ;此处输入代码段代码
    
    MOV DX,OFFSET STR1
    MOV AH,09H
    INT 21H
    
    call INPUT_NAME;调用输入名字函数
    
    MOV DX,OFFSET STR2
    MOV AH,09H
    INT 21H
    
    call INPHONE;调用输入电话函数
    
    ;输出回车
	 mov dl,0dh
	 mov ah,2
	
	 int 21h
	 mov dl,0ah
	
	 mov ah,2
	 int 21h
    
    call PRINTLINE;调用输出函数
    
    MOV AH,4CH
    INT 21H
main endp
    
INPUT_NAME proc near
    push ax
    push bx
    push cx
    
    mov cx,0
    mov cl,20;把cx变成最大的名字长
    ;调用输入函数
    call GETCHAR
    ;由于getchar中有一个循环操作，会减少cx，
    ;所以，cx现在的值是最大长度-实际长度
    mov ax,0
    mov al,20;把ax变成最大名字长
    sub al,cl;al存的是实际长度
    
    mov si,0
    mov cx,ax;cx存的是实际长度
    ;把数据从inpuf放回到outname中
next1:
	mov al,inbuf[si]
	mov outname[si],al
	inc si
	
	loop next1
    
    pop cx
    pop bx
    pop ax
    ret
INPUT_NAME endp
    
INPHONE proc near
	push ax
    push bx
    push cx
	
	mov cx,0
    mov cl,8
    
    ;调用输入函数
    call GETCHAR
    
    mov ax,0
    mov al,8
    sub al,cl
    
    mov cl,al
	mov si,0
	
	cmp cl,8
	jnz error1;如果不足八位，弹出错误提示
	;把数据从inpuf放到outphone中
next2:
	mov al,inbuf[si]
	;小于30H（比数字0大）
	cmp al,30H
	jl error2
	;大于39H（比数字9大）
	cmp al,39H
	ja error2
	mov outphone[si],al
	inc si
	loop next2
	
	jmp exit2
	
	;不足8位错误
error1:
	MOV DX,OFFSET STR3
    MOV AH,09H
    INT 21H
    jmp exit2
    
    ;输入不是数字错误
error2:
	MOV DX,OFFSET STR4
    MOV AH,09H
    INT 21H
exit2:
	pop cx
    pop bx
    pop ax
	ret
INPHONE endp

GETCHAR proc near
	 push ax
	 push dx
	 ;位置
	 mov di,0
rotate:
	;输入
	 mov ah,01
	 int 21h
	;判断回车
	 cmp al,0dh
	 je exit1
	;存入inpuf
	 mov inbuf[di],al
	 inc di
	
	 loop rotate
exit1:
	 pop dx
	 pop ax
	ret
GETCHAR endp

PRINTLINE proc near
	 push ax
	 push dx
	
	 lea dx,tabletitle
	 mov ah,09
	 int 21h
	
	 mov dx,offset outname
	 mov ah,09
	 int 21h
	
	 mov dx,offset outphone
	 mov ah,09
	 int 21h
	
	 pop dx
	 pop ax
	ret
PRINTLINE endp
CODES ENDS
    END main

















