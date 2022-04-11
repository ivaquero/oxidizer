##########################################################
# weather
##########################################################

# -a: all, -g: geographical, -d: day, -n: night
wtr() {
    case $2 in
    -a)
        curl wttr.in/$1
        ;;
    -d)
        curl v2d.wttr.in/$1
        ;;
    -n)
        curl v2d.wttr.in/$1
        ;;
    -g)
        curl v3.wttr.in/$1
        ;;
    -h)
        echo "param 1:\n city: new+york\n airport(codes): muc \n resort: ~Eiffel+Tower\n ip address: @github.com\n help: :help"
        echo "param 2:\n a: all\n d: day \n n: night\n g: geographical\n f: format"
        ;;
    *)
        curl v2.wttr.in/$1
        ;;
    esac
}
