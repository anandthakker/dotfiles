
# Clone dotfiles into ~/dotfiles, then run this.

cd $HOME
for i in $(ls -a dotfiles/ | grep "^\.[^\.]" | grep -v '^.git$')
do
  [ -f $i -o -d $i  ] && echo "$i exists: skipping." || (ln -s dotfiles/$i && echo "Linked $i.")
done
