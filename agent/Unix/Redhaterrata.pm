# Plugin "RedHat Errata" OCSInventory


package Ocsinventory::Agent::Modules::Redhaterrata;

use Encode qw(decode);
use POSIX qw(strftime);

sub new {

    my $name="redhaterrata"; # Name of the module

    my (undef,$context) = @_;
    my $self = {};

    #Create a special logger for the module
    $self->{logger} = new Ocsinventory::Logger ({
        config => $context->{config}
    });
    $self->{logger}->{header}="[$name]";
    $self->{context}=$context;
    $self->{structure}= {
        name => $name,
        start_handler => undef,    #or undef if don't use this hook
        prolog_writer => undef,    #or undef if don't use this hook
        prolog_reader => undef,    #or undef if don't use this hook
        inventory_handler => $name."_inventory_handler",    #or undef if don't use this hook
        end_handler => undef       #or undef if don't use this hook
    };
    bless $self;
}

######### Hook methods ############
sub redhaterrata_inventory_handler {

    my $self = shift;
    my $logger = $self->{logger};
    my $common = $self->{context}->{common};
    

    $logger->debug("Yeah you are in redhaterrata_inventory_handler:)");
    
    my ($errata, $package, $severity, $type, $updated);

    my @modes = ('installed', 'updates');
    my $beginswith = 'RH';
    for(@modes){
        $type = $_;
        my @errata = `sudo yum updateinfo list $_`;

        if($? ne 0) {
            $logger->debug("ERROR :command failed in redhaterrata_inventory_handler, exiting ..");
            exit;
        } else {
            $logger->debug("Command executed successfully in redhaterrata_inventory_handler, processing data ..");
        }

        for (@errata) {
            $line = decode('UTF-8', $_);

            if (substr($line, 0, length($beginswith)) eq $beginswith) {
                ($errata, $severity, $package) = split(' ', $line);
                $updated = strftime('%Y-%m-%d %H:%M:%S', localtime);
                ($severity) = split('/', $severity);
                $package =~ s/-[0-9]+:/-/;

                push @{$common->{xmltags}->{REDHATERRATA}},
                {
                    ERRATA => [$errata],
                    PACKAGE    => $package,
                    SEVERITY   => $severity,
                    TYPE  => [$type],
                    UPDATED  => [$updated]
                };
            }
        }
    }
    $logger->debug("Finishing redhaterrata_inventory_handler ..");
}

1;
