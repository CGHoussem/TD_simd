
double dotprod(double *a, double *b, unsigned long long n)
{
  double d = 0.0;
  unsigned long long i = 0;

  for (; i < n; i++)
    d += a[i] * b[i];

  return d;
}
