
extern "C" void c_printf( const char* template_string, ... );

int main()
{    
    c_printf( "Vlados %s %d %b %x %o %c %d %d %d\n", "hi-hi-ha", 15, 15, 15, 15, 'a', 15, 15, 15 );

    return 0;
}