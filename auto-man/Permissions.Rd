%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{Permissions}
\alias{Permissions}
\docType{methods}
\title{
Constructor for objects of type Permissions
}
\description{
The permission a user has for a given Entity. The set of permissoins is a calculation
based several factors including the permission granted by the Entity's ACL and the
User's group membership.


Attributes:
    can_view : Can the user view this entity?
    can_edit : Can the user edit this entity?
    can_move : (Read Only) Can the user move this entity by changing its parentId?
    can_add_child : Can the user add a child entity to this entity?
    can_certified_user_edit : (Read Only) Can the user edit this entity once they become a Certified User?
    can_certified_user_add_child : (Read Only) Can the user add a child entity to this entity once they become
        a Certified User?
    is_certified_user : (Read Only) True, if the user has passed the user certification quiz.
    can_change_permissions : Can the user change the permissions of this entity?
    can_change_settings : Can the user change the settings of this entity?
    can_delete : Can the user delete this entity?
    can_download : Are there any access requirements precluding the user from downloading this entity?
    can_upload : (Read Only) Are there any access requirements precluding the user from uploading into this entity
        (folder or project)?
    can_enable_inheritance : (Read Only) Can the user delete the entity's access control list (so it inherits
        settings from an ancestor)?
    owner_principal_id : (Read Only) The principal ID of the entity's owner (i.e. the entity's 'createdBy').
    can_public_read : (Read Only) Is this entity considered public?
    can_moderate : Can the user moderate the forum associated with this entity?
        Note that only project entity has forum.
    is_certification_required : (Read Only) Is the certification requirement enabled for the project of the entity?
    is_entity_open_data : (Read Only) Returns true if the Entity's DateType equals 'OPEN_DATA', indicating that the
        data is safe to be released to the public.
}
\usage{
Permissions(can_view=NULL, can_edit=NULL, can_move=NULL, can_add_child=NULL, can_certified_user_edit=NULL, can_certified_user_add_child=NULL, is_certified_user=NULL, can_change_permissions=NULL, can_change_settings=NULL, can_delete=NULL, can_download=NULL, can_upload=NULL, can_enable_inheritance=NULL, owner_principal_id=NULL, can_public_read=NULL, can_moderate=NULL, is_certification_required=NULL, is_entity_open_data=NULL)
}
\arguments{
\item{can_view}{}
\item{can_edit}{}
\item{can_move}{}
\item{can_add_child}{}
\item{can_certified_user_edit}{}
\item{can_certified_user_add_child}{}
\item{is_certified_user}{}
\item{can_change_permissions}{}
\item{can_change_settings}{}
\item{can_delete}{}
\item{can_download}{}
\item{can_upload}{}
\item{can_enable_inheritance}{}
\item{owner_principal_id}{}
\item{can_public_read}{}
\item{can_moderate}{}
\item{is_certification_required}{}
\item{is_entity_open_data}{}
}
\value{
An object of type Permissions
}


