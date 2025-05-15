\name{get_bonsai_frame}
\title{Get Bonsai Frame}
\description{Get the data frame representation of a ASCII art bonsai with a message.}
\usage{
    get_bonsai_frame(message = NULL)
}
\arguments{
    \item{message}{A message to be attached to the bonsai.}
}
\value{
    A data frame such that each cell represents a character in the grid that builds a ASCII art bonsai.
}
\examples{
    get_bonsai_frame()
    get_bonsai_frame("Hello World!")
}