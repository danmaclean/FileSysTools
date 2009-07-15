package Files;

use strict;
use Exporter;

use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);
$VERSION = 0.1;
@ISA = qw(Exporter);
@EXPORT = ();
@EXPORT_OK = qw();
%EXPORT_TAGS = (DEFAULT => [qw()],
				ALL =>[qw()]);
				

sub get_array_of_files{
my $dir = shift;
die unless $dir; 
opendir DIR, $dir || die "Can't open directort $dir";
my @files = readdir(DIR);
close DIR;
for (my $i =0; $i< scalar( @files); ++$i){
	if ($files[$i] eq '.' or $files[$i] eq '..'){
			splice(@files,$i,1);
			--$i;
	}
}
return @files;
}
				
sub slurp_list_file_into_hash{
	my $file = shift;
	my %hash;
	open FILE, "<$file" || die "died opening $file";
		while (my $line = <FILE>){

		chomp($line);
		uc($line);
		$line =~ s/\s//g;
		$hash{$line} = 1;

		} 

	return %hash;
} 

sub strip_whitespace{

	$_[0] =~ s/\s+//g;
	return $_[0];	
	

}

1;
