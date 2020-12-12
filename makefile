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
all: dotprod_O1.s dotprod_O2.s dotprod_O3.s dotprod_Ofast.s dotprod_kamikaze.s

dotprod_O1.s: dotprod.c
	$(CC) -S $(O1_FLAGS) $< -o $(CC)/$@
	$(CC2) -S $(O1_FLAGS) $< -o $(CC2)/$@

dotprod_O2.s: dotprod.c
	$(CC) -S $(O2_FLAGS) $< -o $(CC)/$@
	$(CC2) -S $(O2_FLAGS) $< -o $(CC2)/$@

dotprod_O3.s: dotprod.c
	$(CC) -S $(O3_FLAGS) $< -o $(CC)/$@
	$(CC2) -S $(O3_FLAGS) $< -o $(CC2)/$@

dotprod_Ofast.s: dotprod.c
	$(CC) -S $(OFAST_FLAGS) $< -o $(CC)/$@
	$(CC2) -S $(OFAST_FLAGS) $< -o $(CC2)/$@

dotprod_kamikaze.s: dotprod.c
	$(CC) -S $(KAMIKAZE_FLAGS) $< -o $(CC)/$@
	$(CC2) -S $(KAMIKAZE_FLAGS) $< -o $(CC2)/$@

clean:
	rm -Rf $(CC)/* $(CC2)/*
