
double dotprod(double *a, double *b, unsigned long long n)
{
  double d = 0.0;
  double d_2 = 0.0;
  double d_3 = 0.0;
  double d_4 = 0.0;
  unsigned long long i = 0;
  if (n&1) 
  {
    d += a[i] * b[i];
    i++;
  }
  for (; i < n; i+=4) {
    d += a[i] * b[i];
    d_2 += a[i+1] * b[i+1];
    d_3 += a[i+2] * b[i+2];
    d_4 += a[i+3] * b[i+3];
  }

  return d + d_2 + d_3 + d_4;
}
