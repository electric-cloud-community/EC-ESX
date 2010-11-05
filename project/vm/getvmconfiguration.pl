##########################
# getvmconfiguration.pl
##########################
use warnings;
use strict;

my $opts;

$opts->{sdk_installation_path} = '$[sdk_installation_path]';
$opts->{connection_config} = "$[connection_config]";
$opts->{esx_vmname} = "$[esx_vmname]";
$opts->{esx_number_of_vms} = "$[esx_number_of_vms]";
$opts->{esx_properties_location} = "$[esx_properties_location]";

$[/myProject/procedure_helpers/preamble]

$gt->getvmconfiguration();
exit($opts->{exitcode});