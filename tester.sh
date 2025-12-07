#!/bin/bash

test_list() {
	nums="$1"
	moves=$(./push_swap $nums | wc -l)
	checker=$(./push_swap $nums | ./checker_linux $nums)
	val=$(valgrind ./push_swap $nums)
	echo "numeros: $nums || $moves movimentos || checker_linux: $checker"
}

test_list_sem_numeros() {
	nums="$1"
	moves=$(./push_swap $nums | wc -l)
	checker=$(./push_swap $nums | ./checker_linux $nums)
	val=$(valgrind ./push_swap $nums)
	echo "$moves movimentos || checker_linux: $checker"
}

# test_invalid() {
# 	input="$1"
# 	output=$(./push_swap "$input" 2>&1)
# 	echo "$output"
# }

echo "Testando 3 números"
for a in 1 2 3; do
  for b in 1 2 3; do
	for c in 1 2 3; do
	  if [ "$a" != "$b" ] && [ "$a" != "$c" ] && [ "$b" != "$c" ]; then
		test_list "$a $b $c"
	  fi
	done
  done
done

echo "Testando 5 números"
for a in 1 2 3 4 5; do
  for b in 1 2 3 4 5; do
    for c in 1 2 3 4 5; do
      for d in 1 2 3 4 5; do
        for e in 1 2 3 4 5; do
          if [ "$a" != "$b" ] && [ "$a" != "$c" ] && [ "$a" != "$d" ] && [ "$a" != "$e" ] &&
             [ "$b" != "$c" ] && [ "$b" != "$d" ] && [ "$b" != "$e" ] &&
             [ "$c" != "$d" ] && [ "$c" != "$e" ] &&
             [ "$d" != "$e" ]; then
            test_list "$a $b $c $d $e"
          fi
        done
      done
    done
  done
done


echo "Testando 100 números"
for i in {1..5}; do
	nums=$(shuf -i 1-100 -n 100)
	test_list_sem_numeros "$nums"
done

echo "Testando 500 números"
for i in {1..5}; do
	nums=$(shuf -i 1-500 -n 500)
	test_list_sem_numeros "$nums"
done

echo "Testando entradas inválidas"
test_invalid ""
test_invalid "   "
test_invalid "--1 5 4 2"
test_invalid "++5 8 2"
test_invalid "42ggh 4 1"
test_invalid "6859g 229 793"
test_invalid "1 -1 2 -2 2147483648"
test_invalid "1 -1 2 -2 -2147483649"
test_invalid "2 1 3 -2 1"

echo "Entradas invlaidas sem mensagem de erro"
test_invalid "-1 0 1 2 3 4 5 6 7 8 9"
test_invalid "42"
./push_swap

