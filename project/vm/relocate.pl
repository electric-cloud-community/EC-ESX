##########################
# relocate.pl
##########################
use warnings;
use strict;

my $opts;

$opts->{sdk_installation_path} = '$[sdk_installation_path]';
$opts->{connection_config} = "$[connection_config]";
$opts->{esx_vmname} = "$[esx_vmname]";
$opts->{esx_vmhost_destination} = "$[esx_vmhost_destination]";
$opts->{esx_datastore} = "$[esx_datastore]";
$opts->{esx_number_of_vms} = "$[esx_number_of_vms]";

$[/myProject/procedure_helpers/preamble]

$gt->relocate();
exit($opts->{exitcode});