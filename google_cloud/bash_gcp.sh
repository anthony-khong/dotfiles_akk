
function gcp-external-ip() {
    gcloud compute instances describe $1 | grep "natIP"  | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}'
}

function gce() {
    if [ "$2" = "create" ]; then
        gcloud compute instances create $1 \
            --image-family ubuntu-1804-lts \
            --image-project gce-uefi-images \
            --metadata-from-file startup-script=$HOME/dotfiles/google_cloud/startup.sh \
            --machine-type="$3" \
            --boot-disk-size="$4GB"

    elif [ "$2" = "mosh" ]; then
        mosh --ssh="ssh -i ~/.ssh/google_compute_engine" ubuntu@$(gcp-external-ip $1)

    elif [ "$2" = "ssh" ]; then
        gcloud compute ssh ubuntu@$1
    else
        gcloud compute instances $2 $1

    fi
}

# gce matahari create n1-standard-4 64
# NOTE: use highmem for actual instance
# TODO: put data into storage
# TODO: find out how to connect compute instance and storage
