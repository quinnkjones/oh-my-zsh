# chucknorris: Chuck Norris fortunes

# Automatically generate or update Chuck's compiled fortune data file
# $0 must be used outside a local function. This variable name is unlikly to collide.
CHUCKNORRIS_PLUGIN_DIR=${0:h}

() {
local DIR=$CHUCKNORRIS_PLUGIN_DIR/fortunes
RJOKE=`curl -s https://api.icndb.com/jokes/random/3`

 local strfile=strfile
 if ! which strfile &>/dev/null && [[ -f /usr/sbin/strfile ]]; then
    strfile=/usr/sbin/strfile
 fi
 if ! which $strfile &> /dev/null; then
    echo "[oh-my-zsh] chucknorris depends on strfile, which is not installed" >&2
    echo "[oh-my-zsh] strfile is often provided as part of the 'fortune' package" >&2
 fi

if [[ ! -z  $RJOKE ]]; then
   echo $RJOKE | python $DIR/../jsonReparse.py $DIR
   $strfile $DIR/fortunesinetjokes $DIR/fortunesinetjokes.dat >/dev/null
    alias chuck="fortune -a $DIR/fortunesinetjokes"

else

   if [[ ! -f $DIR/chucknorris.dat ]] || [[ $DIR/chucknorris.dat -ot $DIR/chucknorris ]]; then
      # For some reason, Cygwin puts strfile in /usr/sbin, which is not on the path by default
      $strfile $DIR/chucknorris $DIR/chucknorris.dat >/dev/null
      alias chuck="fortune -a $DIR/chucknorris"
   fi
fi

# Aliases

alias chuck_cow="chuck | cowthink"
}

unset CHUCKNORRIS_PLUGIN_DIR
