
double dotprod(double *a, double *b, unsigned long long n)
{
  double d = 0.0;

  for (unsigned long long i = 0; i < n; i++)
    d += a[i] * b[i];

  return d;
}

