# dvc set up
# only used to initialize a new DVC repository
while getopts w:g:r:d:f:u:i:s: flag
do
    case "${flag}" in
        w) workdir=${OPTARG};;
        g) giturl=${OPTARG};;
        r) reponame=${OPTARG};;
        d) dataname=${OPTARG};;
        f) filename=${OPTARG};;
        u) endpointurl=${OPTARG};;
        i) access_key_id=${OPTARG};;
        s) secret_access_key=${OPTARG};;
    esac
done

cd $workdir && 
git clone $giturl 
cd $reponame && 
/home/matthew_boccalon/.local/bin/dvc init &&
touch .gitignore && echo $filename > .gitignore && 
/home/matthew_boccalon/.local/bin/dvc remote add ${dataname} --local "s3://bhklab_orcestra/dvc/${dataname}/" && 
/home/matthew_boccalon/.local/bin/dvc remote modify ${dataname} --local endpointurl $endpointurl && 
/home/matthew_boccalon/.local/bin/dvc remote modify ${dataname} --local access_key_id $access_key_id && 
/home/matthew_boccalon/.local/bin/dvc remote modify ${dataname} --local secret_access_key "${secret_access_key}" && 
git add . && git commit -m "Initialize dvc repo."

git push
