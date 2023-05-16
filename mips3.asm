.data
	size: 20
 	newline: .asciiz "\n"
 	newSpace: .asciiz " "
 	soma: .asciiz "Soma: "
 	myArray:
 	.align 2 	#alinha palavra na posição correta 
 	.space 80	#array de 20 inteiros
 .text 
 	#AVISO AVISO AVISO
 	#O MAIN NAO ESTÁ PRONTO CORRETAMENTE, ELE ESTÁ FEITO DE FORMA QUE RODE PARA TESTAR AS FUNÇÕES
 	
 	.main:  
 	 	
 	lw $s7, size #tamanho de myArray
 	li $t1, 71 #valor passado para inicializaVetor
 	la, $s0, myArray
 	 	
 	#CHAMA INICIALIZAVETOR
 	move $a0, $s0 #endereço primeira posição vetor
 	move $a1, $s7 #move para o paramentro o tam do vetor
 	move $a2, $t1 #move o valor passado para a função
 	jal inicializaVetor
 	move $s1, $v0 #guarda o valor da soma
 	 
 	#CHAMA IMPRIME VETOR
 	move $a0, $s0 #endereço primeira posição vetor
 	move $a1, $s7 #tam
 	jal imprime
 	 
	#CHAMA ORDENA VETOR
 	move $a0, $s0 #endereço primeira posição vetor
 	move $a1, $s7 #tam
 	jal ordenaVetor
 	 
 	#CHAMA IMPRIME VETOR
 	move $a0, $s0 #endereço primeira posição vetor
 	move $a1, $s7 #tam
 	jal imprime
 	 
 	#CHAMA ZERAVETOR
 	move $a0, $s0 #endereço primeira posição vetor
 	li $t0, 80           #local da ultima posição do vetor
 	la $a1, myArray($t0)     #endereço para a ultima posição 
 	jal zeraVetor
 	 
 	#CHAMA IMPRIME VETOR
 	move $a0, $s0 #endereço primeira posição vetor
 	move $a1, $s7 #tam
 	jal imprime
 	 
 	#IMPRIME A SOMA NO FINAL
 	la $a0, soma
 	li $v0, 4
 	syscall
 	 
 	move $a0, $s1
 	li $v0, 1
 	syscall
 	 
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
		lw $t2, 0($a0)
		lw $t3, 0($a1)
		sw $t2, 0($a1)
		sw $t3, 0($a0)
		
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
	ordenaVetor:
	#Prologo
	addi $sp, $sp, -24
	sw $ra, 20($sp)
	sw $s0, 16($sp)
	sw $s1, 12($sp)
	sw $s2,	8($sp)
	sw $s3, 4($sp)
	sw $s4, 0($sp)
	move $s0, $a1 #s0 = n
	move $s1, $a0 #s1 = inicio do vetor
	#Corpo
	move $s2, $zero #i=0
	addi $s3, $s0, -1 #s3 = n-1
	for1:
		bge $s2, $s3, fimFor1 #if(i>=n-1) sai do laco
		
		move $s4, $s2	#min_idx =i
		addi $t3, $s2, 1	#j = i +1
		for2:
			bge $t3, $s0, fimFor2
			sll $t5, $t3, 2 #t5 = j *4
			add $t6, $s1, $t5 #t6 = &vet[j]
			lw $t6, 0($t6)	#t6 =vet[j]
			sll $t5, $s4, 2 #t5 = min_idx * 4
			add $t7, $s1, $t5	#t7 = &vet[min_idx]
			lw $t7, 0($t7)	#t7= vet[min_idx]
			
			bge $t6, $t7, else2
			move $s4, $t3
			else2:
			
			addi $t3, $t3, 1 #j++
			j for2
		fimFor2:
		beq $s4, $s2, else
		sll $t8, $s4, 2
		add $a0, $s1, $t8
		sll $t9, $s2, 2
		add $a1, $s1, $t9
		jal troca
		else:
			
		addi $s2, $s2, 1 #i++
		j for1
	fimFor1:
	
	#Epilogo
	lw $ra, 20($sp)
	lw $s0, 16($sp)
	lw $s1, 12($sp)
	lw $s2,	8($sp)
	lw $s3, 4($sp)
	lw $s4, 0($sp)
	
	addi $sp, $sp, 24
	
	jr $ra #devolve o controle

	