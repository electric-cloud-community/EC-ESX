##########################
# revert.pl
##########################
use warnings;
use strict;

my $opts;

$opts->{sdk_installation_path} = '$[sdk_installation_path]';
$opts->{connection_config} = "$[connection_config]";
$opts->{esx_vmname} = "$[esx_vmname]";
$opts->{esx_snapshotname} = "$[esx_snapshotname]";
$opts->{esx_poweron_vm} = "$[esx_poweron_vm]";
$opts->{esx_number_of_vms} = "$[esx_number_of_vms]";

$[/myProject/procedure_helpers/preamble]

$gt->revert();
exit($opts->{exitcode});