.data
 	size: 20
 	newline: .asciiz "\n"
 	newSpace: .asciiz " "
 	myArray:
 	.align 2 	#alinha palavra na posição correta 
 	.space 80	#array de 20 inteiros
 .text 
 	#AVISO AVISO AVISO
 	#O MAIN NAO ESTÁ PRONTO CORRETAMENTE, ELE ESTÁ FEITO DE FORMA QUE RODE PARA TESTAR AS FUNÇÕES, NESSE CASO A INICIALIZAVETOR
 	
 	.main:  
 	
 	#Carrega parâmetros
 	la $a0, myArray  
	lw $a1, size
	li $a2, 71  
	
	#Inicializa vetor 
	jal inicializaVetor
	
	#imprime resultado da soma que veio do inicializaVetor 
	move $a0, $v0 		#Pega resultado da soma 
	li $v0, 1          	
	syscall 
	
	# Qubra de linha (apenas visual)
	li $v0, 4             
	la $a0, newline        
	syscall
	
	#imprime vetor 
	la $a0, myArray 
	lw $a1, size
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
			#Carrega parametros
			move $a0, $t2  
			li $a1, 47
			li $a2, 97
			li $a3, 337
			li $t3, 3 
			addi $sp , $sp , -4  #poe quinto parametro na pilha 
			sw $t3 , 0( $sp ) 
			
			#gera numero aleatorio 
			jal numeroAleatorio 
			move $s0, $v0  #poe o numeroAleatorio em s0
			addi $sp , $sp , 4 #corrige pilha 
			
			
			#coloca o numero aleatorio na ultila posição do vetor 
			addi $s2,$s2, -1  #n - 1 
			sll $t4, $s2, 2   #n *4
			add $s1, $s1, $t4 #pulo pra ultima posição do vetor disponivel
			sw $s0, 0($s1)    #coloco o resultado do a0 nessa posição 
			sub  $s1, $s1, $t4 #volto o ponteiro do vetor pro inicio
			
			
			#Carrega parametros para chamar denovo a funçaõ
			move $a0, $s1  #vetor
			move $a1, $s2  #tamanho n
			move $a2, $s0  #numero aleatorio gerado nessa chamada 
		
			#recursao 
			jal inicializaVetor 
			
			move $t5 , $v0  #resultado da recursao 
			add $v0, $s0, $t5   #soma numero aleatorio dessa chamada + resultado da recursão

			
			#Recupera informações da pilha para poder retornar para quem chamou 
			lw $s0, 0($sp)
			lw $s1, 4($sp) 
			lw $s2, 8($sp) 
			lw $ra, 12($sp) 
			addi $sp, $sp, 16

			jr $ra    # volta p quem chamou
	
	#ATENÇÃO !!! 		
	#FUNÇÃO DE ORDENAR VETOR ESTA NO OUTRO ARQUIVO, RETIREI DAQUI POIS PRECISAVA RODAR O PROGRAMA PARA TESTAR 
	