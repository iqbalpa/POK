.data
infantri: .asciiz "Masukkan jumlah infantri: "
tank: .asciiz "Masukkan jumlah tank: "
pesawat: .asciiz "Masukkan jumlah pesawat tempur: "
batalion: .asciiz "Masukkan jumlah batalion yang ingin dibentuk: "

satu: .asciiz "Masing-masing batalion berisikan "
dua: .asciiz " infantri, "
tiga: .asciiz " tank, dan "
empat: .asciiz " pesawat tempur.\n"

tidakAda: .asciiz "Tidak ada pasukan yang tersisa di markas"
lima: .asciiz "jumlah pasukan di markas tersisa "
enam: .asciiz " infantri, "
tujuh: .asciiz " tank, dan "
delapan: .asciiz " pesawat tempur."

.text

.globl main
main:	
	# t0 = infantri
	# t1 = tank
	# t2 = pesawat tempur
	# t3 = batalion
	# s0 = infanteri / batalion 
	# s1 = tank / batalion
	# s2 = pesawat tempur / batalion
	# s3 = infanteri % batalion
	# s4 = tank % batalion
	# s5 = pesawat tempur % batalion
	
	li $v0, 4		# menampilkan pesan infantri
	la $a0, infantri
	syscall
	li $v0, 5		# meminta input jumlah infantri
	syscall
	add $t0, $v0, $zero	# dan disimpan ke t0
	
	li $v0, 4		# menampilkan pesan tank
	la $a0, tank
	syscall
	li $v0, 5		# meminta input jumlah tank
	syscall
	add $t1, $v0, $zero	# dan disimpan ke t1
	
	li $v0, 4		# menampilkan pesan pesawat
	la $a0, pesawat
	syscall
	li $v0, 5		# meminta input jumlah pesawat tempur
	syscall
	add $t2, $v0, $zero	# dan disimpan ke t2
	
	li $v0, 4		# menampilkan pesan batalion
	la $a0, batalion
	syscall
	li $v0, 5		# meminta input jumlah batalion
	syscall
	add $t3, $v0, $zero	# dan disimpan ke t3
	
	
	# jika input batalion = 0, maka akan kembali meminta input dari awal
	beq $t3, $zero, main	
	
	# jika batalion lebih dari infanteri/tank/pesawat tempur
	# maka akan kembali meminta input dari awal
	bgt $t3, $t0, main
	bgt $t3, $t1, main
	bgt $t3, $t2, main
	
	# infantri / batalion 
	div $t0, $t3
	mflo $s0
	mfhi $s3
	# tank / batalion
	div $t1, $t3
	mflo $s1
	mfhi $s4
	# pesawat tempur / batalion
	div $t2, $t3
	mflo $s2
	mfhi $s5
	
	
	# menampilkan pesan hasil akhir
	li $v0, 4
	la $a0, satu
	syscall
	li $v0, 1
	add $a0, $s0, $zero
	syscall
	li $v0, 4
	la $a0, dua
	syscall
	li $v0, 1
	add $a0, $s1, $zero
	syscall
	li $v0, 4
	la $a0, tiga
	syscall
	li $v0, 1
	add $a0, $s2, $zero
	syscall
	li $v0, 4
	la $a0, empat
	syscall

# mengecek apakah ada sisa pasukan
cekInfantri:
	beq $s3, $zero, cekTank
	j tersisa
cekTank: 
	beq $s4, $zero, cekPesawat
	j tersisa
cekPesawat:
	beq $s5, $zero, takTersisa
	j tersisa

# jika tidak ada sisa pasukan
takTersisa:
	li $v0, 4
	la $a0, tidakAda
	syscall
	
# jika ada sisa pasukan
tersisa:
	li $v0, 4
	la $a0, lima
	syscall
	li $v0, 1
	add $a0, $s3, $zero
	syscall
	li $v0, 4
	la $a0, enam
	syscall
	li $v0, 1
	add $a0, $s4, $zero
	syscall
	li $v0, 4
	la $a0, tujuh
	syscall
	li $v0, 1
	add $a0, $s5, $zero
	syscall
	li $v0, 4
	la $a0, delapan
	syscall	

exit:
	li $v0, 10		# system exit
	syscall
