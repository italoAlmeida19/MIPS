.data
 	newline: .asciiz "\n"
 	newSpace: .asciiz " "
 	myArray:
 	.align 2 	#alinha palavra na posição correta 
 	.space 80	#array de 20 inteiros
 .text 
 	#AVISO AVISO AVISO
 	#O MAIN NAO ESTÁ PRONTO CORRETAMENTE, ELE ESTÁ FEITO DE FORMA QUE RODE PARA TESTAR AS FUNÇÕES, NESSE CASO A INICIALIZAVETOR
 	
 	.main:  
 	la $a0, myArray  #vetor
	li $a1, 20
	li $a2, 71  
	
	jal inicializaVetor
	
	la $a0, myArray  #vetor
	li $a1, 20
	jal imprime 

 	#Finaliza programa 
 	li $v0, 10 
 	syscall 
 	
 	
 	imprime:  #função de imprime vetor
 		move $t0, $a0  #Coloca o endereço do vetor que veio por parâmetro dentro de $t0
 		li  $t1, 0     # i = 0 dentro de $t1
 		sll $t2, $a1, 2  #Coloca o tamanho do vetor em bytes dentro de $t2
 			while:
				li $v0, 1          	#Imprimir inteiro
				lw $a0, 0($t0)          #Coloca o valor de vet[i] dentro de a0 p imprimir 
				syscall          	#imprime 
				
				li $v0, 4       	# Espaço entre elementos
				la $a0, newSpace        
				syscall
				
				addi $t0, $t0, 4      #anda 1 posição no vetor
				addi $t1, $t1, 4      #anda a variavel de controle 
				
				blt $t1, $t2, while   #se i > tamBytesVetor quebra o loop
				
				li $v0, 4             # Qubra de linha
				la $a0, newline        
				syscall
				
				jr $ra   	      #Volta pra quem chamou
	
	
	zeraVetor:  #função de zerar vetor
		move $t0, $a0  #guada primeira posição endereço
		move $t1, $a1  #guarda ultima posição endereço
		whileZera:
			bgt $t0, $t1, fim  #posicao inicial > posição final ? caso afirmativo pular para fim 
			sw $zero, 0($t0)   #coloca 0 na vet[atual]
			addi $t0, $t0, 4   #avança para proximo elemento do vetor 
			j whileZera	   #pula para whileZera
		fim:
		jr $ra		           #Volta pra quem chamou
	
	
	numeroAleatorio:
		lw  $t3, 0($sp)  #acessa o 4 parâmetro na pilha
		
		mul $t0, $a0, $a1 #realiza todas as operações
		add $t1, $t0, $a2
		div $t1, $a3
		mfhi $t2
		sub $t4,$t2, $t3
		move $v0, $t4     #poe resultado no v0 
		jr $ra            #retorno 
		
		
	troca:
		move $t0, $a0
		move $t1, $a1
		beq $t0, $t1, fim #se a == b vai para fim
		
		move $t2, $t0 # aux == a
		move $t0, $t1 # a == b
		move $t1, $t2 # b == aux
		
		fim1:
		jr $ra
		
		# ATENÇÃO IMCOMPLETO
	inicializaVetor:
		#Salvo na pilha todos os S que irei usar na função e o ra
		addi $sp, $sp, -16	
		sw $s0, 0($sp)
		sw $s1, 4($sp) 
		sw $s2, 8($sp) 
		sw $ra, 12($sp)     
		
		move $s1, $a0  #vetor
		move $s2, $a1  #tamanho n 
		move $t2, $a2  #ultimo valor INT 
		
		bgt, $s2, $zero, prox	#verifica se tamanho >=0
		
		#Recupera informações da pilha para poder retornar para quem chamou 
		lw $s0, 0($sp)
		lw $s1, 4($sp) 
		lw $s2, 8($sp) 
		lw $ra, 12($sp) 
		addi $sp, $sp, 16
		li $v0, 0
		jr $ra		
		
		prox:
			move $a0, $t2  #Carrega parametros
			li $a1, 47
			li $a2, 97
			li $a3, 337
			li $t3, 3 
			addi $sp , $sp , -4  #poe quinto parametro na pilha 
			sw $t3 , 0( $sp ) 
			
			jal numeroAleatorio  #chama a funcao
			move $s0, $v0  #resultado em s0
			addi $sp , $sp , 4 #corrige pilha 
			
			
			sll $t4, $s2, 2   #n *4
			add $t0, $s1, $t4 #pulo pra ultima posição do vetor disponivel
			sw $s0, 0($t0)    #coloco o resultado do a0 nessa posição 
			sub  $s1, $s1, $t4 #volto pro inicio
			
			#Carrega parametros
			move $a0, $s1  #vetor
			addi $s2,$s2, -1   
			move $a1, $s2  #tamanho n -1
			move $a2, $s0  #novo valor do s0
		
			jal inicializaVetor 
			move $t5 , $v0  #resultado da recursao 
			
			
			add $v0, $s0, $t5   #soma novo valor + resultado da recursão
			
			
			#Recupera informações da pilha para poder retornar para quem chamou 
			lw $s0, 0($sp)
			lw $s1, 4($sp) 
			lw $s2, 8($sp) 
			lw $ra, 12($sp) 
			addi $sp, $sp, 16
			
			jr $ra    # volta p quem chamou 
			
		
		# ATENÇÃO IMCOMPLETO, VOU FAZER HJ A NOITE		
 	ordenaVetor:
		move $t0, $a0 #vetor[]
		move $t1, $a1 # int n
		li $t2, 0 # i = 0
		addi $t3, $t2, 1 # j = i + 1
		addi $t4, $t3, -1 # n - 1
		LACO1: bge, $t2, $t4, proxIf
			move $t5, $t2
			LACO2: bge $t3, $t1, fimLoops
				
			addi $t2, $t2, 1
			j LACO1
					
