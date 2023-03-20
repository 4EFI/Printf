
extern "C" void c_printf( const char* str, ... );

int main()
{    
    c_printf( "Vlados %% %s %% %d %b %x %o %c %d %d %d\n", "hi-hi-ha", 15, 15, 15, 15, 'a', 15, 15, 15 );

    c_printf( "Sanya %d %d %d %d %d %d %d\n", 1, 1, 1, 1, 1, 1, 1 );

    return 0;
}