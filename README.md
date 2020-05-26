IBM-PC汇编语言程序设计（第二版）
====
P244 6.9
编写一个子程序嵌套结构的程序模块，分别从键盘输入姓名及8个字符的电话号码，并以一定的格式显示出来。
----
主程序TELIST：
   （1）显示提示符INPUT NAME:
   （2）调用子程序INPUT_NAME 输入姓名
   （3）显示提示符INPUT A TELEPHONE NUMBER
   （4）调用子程序INPHONE输入电话号码
   （5）调用子程序PRINTLINE显示姓名及电话号码
   
子程序INPUT_NAME
   （1）调用键盘输入子程序GETCHAR，把输入的姓名存放在INBUF缓冲区
   （2）把INBUF中姓名移入输出行OUTNAME
子程序INPHONE
   （1）调用键盘输入子程序GETCHAR，把输入的的8位号码存放在INBUF缓冲区
   （2）把INBUF中的电话号码移入输出行OUTPHONE
子程序PRINTLNE
    显示姓名及电话号码，格式为：
    NAME    TEL.
    XXX     XXX
