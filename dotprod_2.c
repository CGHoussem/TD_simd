
double dotprod(double *a, double *b, unsigned long long n)
{
  double d = 0.0;
  double d_2 = 0.0;
  unsigned long long i = 0;
  if (n&1) 
  {
    d += a[i] * b[i];
    i++;
  }
  for (; i < n; i+=2) {
    d += a[i] * b[i];
    d_2 += a[i+1] * b[i+1];
  }

  return d + d_2;
}
