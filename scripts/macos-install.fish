#!/usr/bin/env fish

set ver 1.1

# Install or update Caddy on macOS

# Requirements: curl and jq

# changelog
# 1.1:
#   - date: 2026-04-08
#   - better output
# i.0:
#   - date: 2026-04-01
#   - first version

set bin_dir ~/.local/bin
set downloads_dir ~/.local/downloads/caddy
test -d $bin_dir; or mkdir -p $bin_dir
test -d $downloads_dir; or mkdir -p $downloads_dir
set -l gh_user caddyserver

set local_version 0
set action update

if not type -q check_status
    function check_status -a return_value error_message
        if test $return_value -ne 0
            echo $error_message
            exit $return_value
        end
    end
end

type -q jq; or begin; echo >&2 'jq command not found'; exit 1; end

if not type -q is_internet_available
    function is_internet_available
        for sleep_duration in (seq 6 1)
            sleep 1
            ping -c 1 1.1.1.1 &> /dev/null
            if test $status -eq 0
                echo "✓ Internet connectivity: OK"
                break
            end
            if test $sleep_duration -eq 1
                echo >&2 'No Internet'
                return 1
            end
        end
    end
end

is_internet_available; or exit 1

set upstream_version $(curl -jsL "https://api.github.com/repos/$gh_user/caddy/tags" | jq -r '.[0].name' | awk -Fv '{print $2}')
# alternative way
# set upstream_version $(curl -fsSL 'https://api.github.com/repos/$gh_user/caddy/releases/latest' | jq -r .tag_name | awk -Fv '{print $2}')
if test -z $upstream_version
    echo Could not find the latest version from GitHub for some unknown reason.
    echo Probably check the internet connection.
    exit 1
end
set latest_binary caddy_{$upstream_version}_mac_arm64

set download_url https://github.com/$gh_user/caddy/releases/download/v$upstream_version/$latest_binary.tar.gz

# pre-check

echo
echo Bin dir: $bin_dir
echo Downloads dir: $downloads_dir
echo

if test -f $bin_dir/caddy
    set local_version ($bin_dir/caddy version | awk '{print $1}' | string trim -c v)
    echo Installed Version: $local_version
else
    set action install
end

# Debugging
echo Upstream Version: $upstream_version
echo Binary: $latest_binary
echo Download URL: $download_url
echo Action: $action

if test $local_version = $upstream_version
    echo Latest version ($upstream_version) is already installed.
    exit 0
end
echo

# download only if the binary is not already downloaded.
if not test -f $downloads_dir/caddy-$upstream_version
    # remove any old archive
    set --local archive $downloads_dir/$latest_binary.tar.gz
    test -f $archive; and rm $archive

    printf '%-72s' 'Downloading the latest version...'
    curl -jsSL -o $archive $download_url
    check_status $status Error downloading the latest version. Exiting prematurely.
    echo done.

    printf '%-72s' 'Extracting the binary from the downloaded archive...'
    tar xf $archive --directory $downloads_dir/
    check_status $status Error extracting. Exiting prematurely.
    echo done.

    mv $downloads_dir/caddy $downloads_dir/caddy-$upstream_version
end

ln -fs $downloads_dir/caddy-$upstream_version $bin_dir/caddy
check_status $status Exiting switching to the latest version. Exiting prematurely.
echo The caddy binary is linked to the latest version available in the downloads dir.

# clean up
test -f $downloads_dir/$latest_binary.tar.gz; and rm $downloads_dir/$latest_binary.tar.gz
test -f $downloads_dir/LICENSE; and rm $downloads_dir/LICENSE
test -f $downloads_dir/README.md; and rm $downloads_dir/README.md

echo
if test $action = 'install'
    echo Successfully installed Caddy web server.
else
    echo Successfully updated to version: $(caddy version)
end
echo

