\name{Permissions}
\alias{Permissions}
\docType{methods}
\title{
Constructor for objects of type Permissions
}
\description{
The permission a user has for a given Entity. The set of permissions is a calculation
based several factors including the permission granted by the Entity's ACL and the
User's group membership.

}
\usage{
Permissions(can_view=NULL, can_edit=NULL, can_move=NULL, can_add_child=NULL, can_certified_user_edit=NULL, can_certified_user_add_child=NULL, is_certified_user=NULL, can_change_permissions=NULL, can_change_settings=NULL, can_delete=NULL, can_download=NULL, can_upload=NULL, can_enable_inheritance=NULL, owner_principal_id=NULL, can_public_read=NULL, can_moderate=NULL, is_certification_required=NULL, is_entity_open_data=NULL)
}
\arguments{
\item{can_view}{optional named parameter: Can the user view this entity?}
\item{can_edit}{optional named parameter: Can the user edit this entity?}
\item{can_move}{optional named parameter: (Read Only) Can the user move this entity by changing its parentId?}
\item{can_add_child}{optional named parameter: Can the user add a child entity to this entity?}
\item{can_certified_user_edit}{optional named parameter: (Read Only) Can the user edit this entity once they become a Certified User?}
\item{can_certified_user_add_child}{optional named parameter: (Read Only) Can the user add a child entity to this entity once they become a Certified User?}
\item{is_certified_user}{optional named parameter: (Read Only) True, if the user has passed the user certification quiz.}
\item{can_change_permissions}{optional named parameter: Can the user change the permissions of this entity?}
\item{can_change_settings}{optional named parameter: Can the user change the settings of this entity?}
\item{can_delete}{optional named parameter: Can the user delete this entity?}
\item{can_download}{optional named parameter: Are there any access requirements precluding the user from downloading this entity?}
\item{can_upload}{optional named parameter: (Read Only) Are there any access requirements precluding the user from uploading into this entity (folder or project)?}
\item{can_enable_inheritance}{optional named parameter: (Read Only) Can the user delete the entity's access control list (so it inherits settings from an ancestor)?}
\item{owner_principal_id}{optional named parameter: (Read Only) The principal ID of the entity's owner (i.e. the entity's 'createdBy').}
\item{can_public_read}{optional named parameter: (Read Only) Is this entity considered public?}
\item{can_moderate}{optional named parameter: Can the user moderate the forum associated with this entity? Note that only project entity has forum.}
\item{is_certification_required}{optional named parameter: (Read Only) Is the certification requirement enabled for the project of the entity?}
\item{is_entity_open_data}{optional named parameter: (Read Only) Returns true if the Entity's DateType equals 'OPEN_DATA', indicating that the data is safe to be released to the public.}
}
\value{
An object of type Permissions
}


