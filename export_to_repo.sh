#!bash

repopath=/mnt/e/repos/cpenv # Change to repo path
files=(~/.bashrc ~/.vimrc ~/.zshrc ~/.ycm_extra_conf.py ~/.sub_cpp.py ~/autoupd.sh .template.cpp push_config.sh export_to_repo.sh tools/)

for path in ${files[@]}; do
    fname=$(basename -- "$path")
    echo "Exporting $path to $fname"
    
    if [ -d $path ]; then
        if [ -d $repopath/$fname ]; then
            rm -r $repopath/$fname
        fi
        cp -r $path $repopath/$fname
    else
        cp $path $repopath/$fname
    fi
done

