\name{Permissions-class}
\alias{Permissions-class}
\docType{class}
\title{
Permissions
}
\format{An R6 class object.}
\description{
The permission a user has for a given Entity. The set of permissions is a calculation
based several factors including the permission granted by the Entity's ACL and the
User's group membership.

}
\section{Methods}{
\itemize{
\item \code{Permissions(can_view=NULL, can_edit=NULL, can_move=NULL, can_add_child=NULL, can_certified_user_edit=NULL, can_certified_user_add_child=NULL, is_certified_user=NULL, can_change_permissions=NULL, can_change_settings=NULL, can_delete=NULL, can_download=NULL, can_upload=NULL, can_enable_inheritance=NULL, owner_principal_id=NULL, can_public_read=NULL, can_moderate=NULL, is_certification_required=NULL, is_entity_open_data=NULL)}: Constructor for \code{\link{Permissions}}
}
}

