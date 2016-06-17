default['erlang']['dev-packages'] = %w{wxGTK-devel unixODBC-devel}

default['erlang']['version'] = "17.5"
default['erlang']['file_name'] = "erlang-#{node['erlang']['version']}"
default['erlang']['url'] = "https://packages.erlang-solutions.com/erlang/esl-erlang/FLAVOUR_1_general/esl-erlang_#{node['erlang']['version']}-1~centos~7_amd64.rpm"
