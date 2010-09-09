use ElectricCommander;
use File::Basename;
use ElectricCommander::PropDB;
use ElectricCommander::PropMod;

$|=1;

use constant {
	SUCCESS => 0,
	ERROR   => 1,
};

# Create ElectricCommander instance
my $ec = new ElectricCommander();
$ec->abortOnError(0);

if(defined($opts->{connection_config}) && $opts->{connection_config} ne "") {
	my $cfgName = $opts->{connection_config};
	print "Loading config $cfgName\n";
	
	my $proj = "$[/myProject/projectName]";
	my $cfg = new ElectricCommander::PropDB($ec,"/projects/$proj/esx_cfgs");
	
	my %vals = $cfg->getRow($cfgName);
	
	# Check if configuration exists
	unless(keys(%vals)) {
		print "Configuration [$cfgName] does not exist\n";
	    exit ERROR;
	}
	
	# Add all options from configuration
	foreach my $c (keys %vals) {
	    print "Adding config $c = $vals{$c}\n";
	    $opts->{$c}=$vals{$c};
	}
	
	# Check that credential item exists
	if (!defined $opts->{credential} || $opts->{credential} eq "") {
	    print "Configuration [$cfgName] does not contain an ESX credential\n";
	    exit ERROR;
	}
	# Get user/password out of credential named in $opts->{credential}
	my $xpath = $ec->getFullCredential("$opts->{credential}");
	$opts->{esx_user} = $xpath->findvalue("//userName");
	$opts->{esx_pass} = $xpath->findvalue("//password");
	
	# Check for required items
	if (!defined $opts->{esx_url} || $opts->{esx_url} eq "") {
	    print "Configuration [$cfgName] does not contain an ESX server url\n";
	    exit ERROR;
	}
}

$opts->{sdk_installation_path} = '$[sdk_installation_path]';
if($opts->{sdk_installation_path} eq '') {
	$opts->{sdk_installation_path} = 'C:\Program Files\VMware\VMware vSphere CLI\Perl\lib';
}

# Load the actual code into this process
if (!ElectricCommander::PropMod::loadPerlCodeFromProperty(
    $ec,'/myProject/esx_driver/ESX') ) {
    print 'Could not load ESX.pm\n';
    exit ERROR;
}

# Make an instance of the object, passing in options as a hash
my $gt = new ESX($opts);
