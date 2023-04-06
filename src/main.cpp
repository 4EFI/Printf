
extern "C" void c_printf( const char* str, ... );

int main()
{    
    c_printf( "Wayuaaa\n" );
    
    c_printf( "Vlados %% %s %% %d %b %x %o %c %d %d %d\n", "hi-hi-ha", 15, 15, 15, 15, 'a', 15, 15, 15 );

    c_printf( "Sanya %d %d %d %d %d %d %d\n", 1, 1, 1, 1, 1, 1, 1 );

    c_printf( "%d %b\n"
              "-What do you love now?%v\n"
              "%d %s %x %d%%%c%b\n", -1234, 11, 
                                     -1, 
                                     "love",
                                     3802,
                                     100,
                                     33,
                                     127 );

    return 0;
}