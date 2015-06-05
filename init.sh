# Clone dotfiles into ~/dotfiles, then run this from ~/
for i in $(ls -a dotfiles/ | grep "^\.[^\.]") ; do if [ -f $i  ] ; then ln -s dotfiles/$i ; fi ; done
