
extern "C" void c_printf( const char* template_string, ... );

int main()
{    
    c_printf( "Vlados %d %d %d %d %d %d %d %d %d\n", 15, 15, 15, 15, 15, 15, 15, 15, 15 );
    // my_printf( "Wooo %% %d %x %s %b\n", 127, 23, "Boooo", 65 );

    return 0;
}