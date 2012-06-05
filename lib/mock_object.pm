package mock_object;

sub new {
	my ($class, %args) = @_;
	return bless {-canned_responses => \%args}, __PACKAGE__;
}

sub install_at {
	my ($self, $fqmn) = @_;
	no strict 'refs';
	no warnings 'redefine';
	*{$fqmn} = sub { $self };
	return $self;
}

sub AUTOLOAD {
	my ($self, @args) = @_;
	my ($method) = our $AUTOLOAD =~ m{.*:(.*?)$};
	push @{$self->{-method_calls}}, [$method, @args];
	return exists $self->{-canned_responses}{$method}
		? $self->{-canned_responses}{$method}
		: $self;
}

1;
