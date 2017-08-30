extern char *prodMessage;
      void print_int(int a);
      void print_string(char *a);
      int read_int();

      int my_mul(int a, int b)
      {
        int i, ret = 0;
        for(i=0; i<b; i++)
        ret = ret + a;
        return ret;
      }

      int main(void)
      {
        print_string("Enter the first number");
        int num1 = read_int();
        print_string("Enter the second number");
        int num2 = read_int();
        print_string(prodMessage);
        print_int(my_mul(num1, num2));
        return 0;
      }