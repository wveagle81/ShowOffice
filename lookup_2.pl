        
use LWP::UserAgent;
use HTML::TreeBuilder;
use HTML::TreeBuilderX;

my $ua = LWP::UserAgent->new;
my $resp = $ua->get('http://www.appaloosa.com/asna2007/mbrverify.aspx');
my $root = HTML::TreeBuilder->new_from_content( $resp->content );
my $a = $root->look_down( _tag => 'a', id => 'nextPage' );
my $aspnet = HTML::TreeBuilderX::ASP_NET->new({
             element   => $a
             , baseURL =>$resp->request->uri ## takes into account posting redirects
        });
my $resp = $ua->request( $aspnet->httpResponse );

## or the easy cheating way see the SEE ALSO section for links

my $aspnet = HTML::TreeBuilderX::ASP_NET->new_with_traits( traits => ['htmlElement'] );
$form->look_down(_tag=> 'a')->httpResponse

