.data
 	newline: .asciiz "\n"
 	newSpace: .asciiz " "
 	myArray:
 	.align 2 	#alinha palavra na posição correta 
 	.space 80	#array de 20 inteiros
 .text 
 	#AVISO AVISO AVISO
 	#O MAIN NAO ESTÁ PRONTO CORRETAMENTE, ELE ESTÁ FEITO DE FORMA QUE RODE PARA TESTAR AS FUNÇÕES
 	
 	.main:  
 	 	
 	#carrega alguns valores
 	li $s0, 15
 	li $t0, 4
  	li $t1, 8
   	li $t2, 12
    	li $t3, 16
    	
    	
    	#poe essses valores dentro do vetor 
    	sw $s0, myArray($zero)
 	sw $t0, myArray($t0)
 	sw $t1, myArray($t1)
 	sw $t2, myArray($t2)
 	sw $t3, myArray($t3)


 	#chama função imprime para vetor com alguns valores 
 	la $a0, myArray #Coloca a primeira posição do vetor dentro do parametro a0
 	li $a1, 20	#Coloca o tamanho do vetor dentro do parametro a1
 	jal imprime
 	
 	
	#chama função p zerar vetor
 	li $t0, 80               #local da ultima posição do vetor
 	la $a1, myArray($t0)     #endereço para a ultima posição 
 	la $a0, myArray		 #Coloca a primeira posição do vetor dentro do parametro a0
 	jal zeraVetor
 	
 	
 	#chama função imprime para vetor zerado
 	la $a0, myArray 	#Coloca a primeira posição do vetor dentro do parametro a0
 	li $a1, 20		#Coloca o tamanho do vetor dentro do parametro a1
 	jal imprime

	#chama função troca para valores vet[0] e vet[1]
	la $a0, myArray($t0)
	la $a1, myArray($t1)
	jal troca	
	
 	#carrega parametros pra funçao numeroAleatorio
 	li $a0, 10
 	li $a1, 15
 	li $a2, 20
 	li $a3, 25
 	li $t0, 30	
 				#coloca quarto parametro na pilha 
 	addi $sp , $sp , -4 	# Ajusta a pilha
	sw $t0 , 0( $sp ) 	# Salva $t0 na pilha
	
 	jal numeroAleatorio
 	
 	move $s4, $v0  		#guarda em s4 o resultado da função 
 	addi $sp , $sp , 4      # Ajusta a pilha
 	
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
		
		# ATENÇÃO IMCOMPLETO, VOU FAZER HJ A NOITE
	inicializaVetor:
		move $t0, $a0
		move $t1, $a1
		move $t2, $a2
		
		bgt, $t1, $zero, prox
		li $v0, 0
		jr $ra		
		
		prox:
				
	
		
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
			
					