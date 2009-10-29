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
=head1 NAME

Files - a module of File helper methods 

=head1 AUTHOR

Dan MacLean (dan.maclean@tsl.ac.uk)

=head1 SYNOPSIS

	use FileSysTools::Files;
	my $dir = '/home/macleand';
	my @files = Files::get_array_of_files($dir);

=head1 DESCRIPTION

The Files module contains routines for carrying out some frequent file related tasks.
The module does not create objects like some of the other modules, rather its methods are accessed in the manner of subroutines in external files.

=head1 METHODS

=over

=item get_array_of_files(dir)

returns an array of the files in the directory dir

	my $dir = '/home/macleand/Desktop';
	my @files = Files::get_array_of_files($dir);

=item slurp_list_file_into_hash(file)

Takes a file and loads it into a hash, each line in the file becomes a key in the hash

	my $file = 'myfile';
	my %hash = Files::slurp_list_file_into_hash($file);

=item strip_whitespace(line)

Removes whitespace from a provided string.

	my $string = "Do you know the way to San Jose?";
	my $new_string = strip_whitespace($string);

=back


