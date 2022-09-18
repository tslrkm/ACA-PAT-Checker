#!/usr/bin/perl
# allchks - program to check all the ACA PATS
# Author - Tsiolkovsky
# Version: 1.0

# Version History:
# 1 - combines checking for a number of other scripts into one script


    use strict;


    my ($pt, $ct, $ctchr, $ptchr, $cnt1, $cnt2, $str, $string, $ptstr, $ctstr, $message, $msg, $patnum);
    my ($pstr, $pstring, $pmsg, $pat, $crchk);
    my ($cmsg, $crib, $sol, $res);

    my %cipher = ();

    my %cnter;
    my %cneter;
    my $kcount=0;
    my %uniq;
    my @pnum;
    my ($key, $rmval, $chr, $count, $cline, $text, $patlen, $k);
    my $cnter;
    my $single=0;

my %gspot = (65, "G", 66, "H", 67, "I", 68, "J", 69, "K", 70, "L", 71, "M", 72, "N", 73, "O", 74, "P", 75, "Q", 76, "R", 77, "S", 78, "T", 79, "U", 80, "V", 81, "W", 82, "X", 83, "Y", 84, "Z", 85, "A", 86, "B", 87, "C", 88, "D", 89, "E", 90, "F");

    my $outfile = "d1.txt";
    my $infile  = "d1.txt";

    # enter the plaintext alphabet

    print "ACA PAT Checker - Version 1.0\n\n";

    print "PATRISTROCAT number : ";
    chomp($patnum = <STDIN>);    

    print "Plaintext alphabet  : ";
    chomp($ptstr = <STDIN>);

    print "Ciphertext alphabet : ";
    chomp($ctstr = <STDIN>);

    print "Plaintext message   : ";
    chomp($string = <STDIN>);

    print "Final PATRISTROCAT  : ";
    chomp ($pstring = <STDIN>);
    
    print "Encoded Crib        : ";
    chomp ($cmsg = <STDIN>);




    # removes all spaces and punctuation from the PLAINTEXT
    ($str = $string) =~ s/\s//g;
    ($msg = $str) =~ s/[[:punct:]]//g;
    $message = lc($msg);

   # removes all spaces and punctuation from the CIPHERTEXT
    ($pstr = $pstring) =~ s/\s//g;
    ($pmsg = $pstr) =~ s/[[:punct:]]//g;
    $pat = uc($pmsg);

    $crib = uc($cmsg);

    my @ptarr = split("", lc($ptstr));
    my @ctarr = split("", uc($ctstr));
    my @msgar = split("", $message);
    
    $cnt1 = 0;
    $cnt2 = 0;

    # Create the plaintext to cihper text hash
    while($cnt1 <= $#ptarr)
    {
    $pt = $ptarr[$cnt1];
    $ct = $ctarr[$cnt1];
#    print "$pt  - $ct\n";

    $cipher{$pt} = $ct;

    $cnt1++;
    }
    
    #do the conversion and produce the output

    open (RECODE, ">$outfile") || die("could not open $outfile\n");
#    print"\n\nOUT: ";
    while($cnt2 <= $#msgar)
    {
    $ptchr = $msgar[$cnt2];
    $ctchr = $cipher{$ptchr};
#    print "$ctchr";
    print RECODE "$ctchr";
    $cnt2++
    }
    print "\n";
    close (RECODE);


#Breaks strung up and counts occurances of each letter

  my @line = split(//, $pat); 
  $patlen = length($pat);
  if($line[0] eq ">"){print @line, "\n";}
  elsif (($line[0] eq "X"||"Y"||"Z")||($line[0] ne ">"))
  {
      foreach my $gc (@line) 
      {
      	$cnter{$gc} = $cnter{$gc} ? $cnter{$gc} += 1 : 1;
      }
  }
foreach $k(keys %cnter){
  $kcount=$kcount+1;
  $patlen=$patlen+$cnter;
#   print "$k:$cnter{$k}\n";

   if ($cnter{$k} == 1) {
   $single = $single +1;
   }

#  $uniq{$k} = "$cneter{$k}";
}

#gspot-check

my @cribar = split ("", $crib);
my $arraylen = @cribar;
my $gcount = 0;


#this converts the g-spot crib into plaintext

while ($gcount < $arraylen) {

  $key=ord(uc($cribar[$gcount]));
  $rmval=$gspot{$key}; 
#  print "Number: $key = $rmval = $chr\n";
  push (@pnum, $rmval);
  $gcount++;
 }

$text = join('',@pnum);
$text =~ s/(^\s+|\s+$)//g;

$crchk = lc($text);


#print "PAT: $pat\n";





#This displays the results

print "RESULTS : P-$patnum\n";

    if ($patlen < 85) {
        print "PAT Length     : $patlen - TOO SHORT \n";
    } elsif ($patlen > 105) {
        print "PAT Length     : $patlen - TOO LONG \n";
    } else {
        print "PAT Length     : $patlen \n";
    }

    if ($kcount < 18) {
        print "Unique Letters : $kcount - TOO FEW USED \n";
    } elsif ($kcount > 26) {
        print "Unique Letters : $kcount - TOO MANY \n"

    } else {
        print "Unique Letters : $kcount \n";
    }
   
    if ($single > 4) {
        print "Singletons     : $single - TOO MANY SINGLETONS \n";
    } else {
        print "Singletons     : $single \n";
    }
    
        print "Crib           : $crib = $text\n";

    if (index($message, $crchk) != -1) {
        print "Crib Exists    : YES \n";
    } else {
        print "Crib Exists    : NO \n";
    }

open (COMPARE, "$infile") || die("could not open $outfile\n");

$sol = <COMPARE>; 
close (COMPARE);

$res = ($pat cmp $sol);

if ($res eq 0) {

  print "RECODE         : 100% Match \n";
  } else {
  print "RECODE         : FAILURE!! \n";
  }
  





