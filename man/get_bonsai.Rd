\name{get_bonsai}
\title{Get Bonsai}
\description{Get the string representation of a ASCII art bonsai with a message.}
\usage{
    get_bonsai(message = NULL)
}
\arguments{
    \item{message}{A message to be attached to the bonsai.}
}
\value{
    A vector of strings such that each string represents a line in the ASCII art of a bonsai.
}
\examples{
    get_bonsai()
    get_bonsai("Hello World!")
}