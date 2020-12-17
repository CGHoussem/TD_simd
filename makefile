#Compilers
CC=gcc
CC2=clang

#Optimization flags
O1_FLAGS=-O1
O2_FLAGS=-O2
O3_FLAGS=-O3
OFAST_FLAGS=-Ofast
KAMIKAZE_FLAGS=-march=native -mtune=native -Ofast -funroll-loops -finline-functions -ftree-vectorize

#
no_unroll: dotprod_O1.s dotprod_O2.s dotprod_O3.s dotprod_Ofast.s dotprod_kamikaze.s

unroll_2: dotprod_2_O1.s dotprod_2_O2.s dotprod_2_O3.s dotprod_2_Ofast.s dotprod_2_kamikaze.s

unroll_4: dotprod_4_O1.s dotprod_4_O2.s dotprod_4_O3.s dotprod_4_Ofast.s dotprod_4_kamikaze.s

# ---------------------------------------------------------

dotprod_O1.s: dotprod.c
	$(CC) -S $(O1_FLAGS) $< -o $(CC)/no_unroll/$@
	$(CC2) -S $(O1_FLAGS) $< -o $(CC2)/no_unroll/$@

dotprod_O2.s: dotprod.c
	$(CC) -S $(O2_FLAGS) $< -o $(CC)/no_unroll/$@
	$(CC2) -S $(O2_FLAGS) $< -o $(CC2)/no_unroll/$@

dotprod_O3.s: dotprod.c
	$(CC) -S $(O3_FLAGS) $< -o $(CC)/no_unroll/$@
	$(CC2) -S $(O3_FLAGS) $< -o $(CC2)/no_unroll/$@

dotprod_Ofast.s: dotprod.c
	$(CC) -S $(OFAST_FLAGS) $< -o $(CC)/no_unroll/$@
	$(CC2) -S $(OFAST_FLAGS) $< -o $(CC2)/no_unroll/$@

dotprod_kamikaze.s: dotprod.c
	$(CC) -S $(KAMIKAZE_FLAGS) $< -o $(CC)/no_unroll/$@
	$(CC2) -S $(KAMIKAZE_FLAGS) $< -o $(CC2)/no_unroll/$@

# ---------------------------------------------------------

dotprod_2_O1.s: dotprod_2.c
	$(CC) -S $(O1_FLAGS) $< -o $(CC)/unroll_2/$@
	$(CC2) -S $(O1_FLAGS) $< -o $(CC2)/unroll_2/$@

dotprod_2_O2.s: dotprod_2.c
	$(CC) -S $(O2_FLAGS) $< -o $(CC)/unroll_2/$@
	$(CC2) -S $(O2_FLAGS) $< -o $(CC2)/unroll_2/$@

dotprod_2_O3.s: dotprod_2.c
	$(CC) -S $(O3_FLAGS) $< -o $(CC)/unroll_2/$@
	$(CC2) -S $(O3_FLAGS) $< -o $(CC2)/unroll_2/$@

dotprod_2_Ofast.s: dotprod_2.c
	$(CC) -S $(OFAST_FLAGS) $< -o $(CC)/unroll_2/$@
	$(CC2) -S $(OFAST_FLAGS) $< -o $(CC2)/unroll_2/$@

dotprod_2_kamikaze.s: dotprod_2.c
	$(CC) -S $(KAMIKAZE_FLAGS) $< -o $(CC)/unroll_2/$@
	$(CC2) -S $(KAMIKAZE_FLAGS) $< -o $(CC2)/unroll_2/$@

# ---------------------------------------------------------

dotprod_4_O1.s: dotprod_4.c
	$(CC) -S $(O1_FLAGS) $< -o $(CC)/unroll_4/$@
	$(CC2) -S $(O1_FLAGS) $< -o $(CC2)/unroll_4/$@

dotprod_4_O2.s: dotprod_4.c
	$(CC) -S $(O2_FLAGS) $< -o $(CC)/unroll_4/$@
	$(CC2) -S $(O2_FLAGS) $< -o $(CC2)/unroll_4/$@

dotprod_4_O3.s: dotprod_4.c
	$(CC) -S $(O3_FLAGS) $< -o $(CC)/unroll_4/$@
	$(CC2) -S $(O3_FLAGS) $< -o $(CC2)/unroll_4/$@

dotprod_4_Ofast.s: dotprod_4.c
	$(CC) -S $(OFAST_FLAGS) $< -o $(CC)/unroll_4/$@
	$(CC2) -S $(OFAST_FLAGS) $< -o $(CC2)/unroll_4/$@

dotprod_4_kamikaze.s: dotprod_4.c
	$(CC) -S $(KAMIKAZE_FLAGS) $< -o $(CC)/unroll_4/$@
	$(CC2) -S $(KAMIKAZE_FLAGS) $< -o $(CC2)/unroll_4/$@

clean:
	rm -Rf $(CC)/* $(CC2)/*
