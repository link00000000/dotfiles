# Defined in - @ line 1
function __config
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $argv;
end

function config
    if [ $argv[1] = "ls" ]
	__config ls-files
    end

    __config $argv
end
