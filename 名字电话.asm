;author:���·���ѩ
;����������̲ģ��κ�6.9����
DATAS SEGMENT
    ;�˴��������ݶδ��� 
    inbuf db 20 dup(?)
    outname db 20 dup(?),'$'
    outphone db 8 dup(?),'$';������
    
    STR1 db "input name:$"
    STR2 db "input telephone number:$"
    STR3 db "PHONE NUMBER LESS THAN 8$"
    STR4 db "INPUT IS NOT NUMBER$"
    tabletitle db 'NAME',16 dup(20h),'TEL.',13,10,'$'
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
main proc far
    ASSUME CS:CODES,DS:DATAS,SS:STACKS

    MOV AX,DATAS
    MOV DS,AX
    ;�˴��������δ���
    
    MOV DX,OFFSET STR1
    MOV AH,09H
    INT 21H
    
    call INPUT_NAME;�����������ֺ���
    
    MOV DX,OFFSET STR2
    MOV AH,09H
    INT 21H
    
    call INPHONE;��������绰����
    
    ;����س�
	 mov dl,0dh
	 mov ah,2
	
	 int 21h
	 mov dl,0ah
	
	 mov ah,2
	 int 21h
    
    call PRINTLINE;�����������
    
    MOV AH,4CH
    INT 21H
main endp
    
INPUT_NAME proc near
    push ax
    push bx
    push cx
    
    mov cx,0
    mov cl,20;��cx����������ֳ�
    ;�������뺯��
    call GETCHAR
    ;����getchar����һ��ѭ�������������cx��
    ;���ԣ�cx���ڵ�ֵ����󳤶�-ʵ�ʳ���
    mov ax,0
    mov al,20;��ax���������ֳ�
    sub al,cl;al�����ʵ�ʳ���
    
    mov si,0
    mov cx,ax;cx�����ʵ�ʳ���
    ;�����ݴ�inpuf�Żص�outname��
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
    
    ;�������뺯��
    call GETCHAR
    
    mov ax,0
    mov al,8
    sub al,cl
    
    mov cl,al
	mov si,0
	
	cmp cl,8
	jnz error1;��������λ������������ʾ
	;�����ݴ�inpuf�ŵ�outphone��
next2:
	mov al,inbuf[si]
	;С��30H��������0��
	cmp al,30H
	jl error2
	;����39H��������9��
	cmp al,39H
	ja error2
	mov outphone[si],al
	inc si
	loop next2
	
	jmp exit2
	
	;����8λ����
error1:
	MOV DX,OFFSET STR3
    MOV AH,09H
    INT 21H
    jmp exit2
    
    ;���벻�����ִ���
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
	 ;λ��
	 mov di,0
rotate:
	;����
	 mov ah,01
	 int 21h
	;�жϻس�
	 cmp al,0dh
	 je exit1
	;����inpuf
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

















