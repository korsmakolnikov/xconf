(local status-const (require :oil-vcs-status.constant.status))

(local Status-type status-const.StatusType)

((. (require :oil-vcs-status) :setup) {:fs_event_debounce 500
                                       :status_hl_group {Status-type.Added :OilVcsStatusAdded
                                                         Status-type.Copied :OilVcsStatusCopied
                                                         Status-type.Deleted :OilVcsStatusDeleted
                                                         Status-type.External :OilVcsStatusExternal
                                                         Status-type.Ignored :OilVcsStatusIgnored
                                                         Status-type.Modified :OilVcsStatusModified
                                                         Status-type.Renamed :OilVcsStatusRenamed
                                                         Status-type.TypeChanged :OilVcsStatusTypeChanged
                                                         Status-type.Unmerged :OilVcsStatusUnmerged
                                                         Status-type.Unmodified :OilVcsStatusUnmodified
                                                         Status-type.Untracked :OilVcsStatusUntracked
                                                         Status-type.UpstreamAdded :OilVcsStatusUpstreamAdded
                                                         Status-type.UpstreamCopied :OilVcsStatusUpstreamCopied
                                                         Status-type.UpstreamDeleted :OilVcsStatusUpstreamDeleted
                                                         Status-type.UpstreamExternal :OilVcsStatusUpstreamExternal
                                                         Status-type.UpstreamIgnored :OilVcsStatusUpstreamIgnored
                                                         Status-type.UpstreamModified :OilVcsStatusUpstreamModified
                                                         Status-type.UpstreamRenamed :OilVcsStatusUpstreamRenamed
                                                         Status-type.UpstreamTypeChanged :OilVcsStatusUpstreamTypeChanged
                                                         Status-type.UpstreamUnmerged :OilVcsStatusUpstreamUnmerged
                                                         Status-type.UpstreamUnmodified :OilVcsStatusUpstreamUnmodified
                                                         Status-type.UpstreamUntracked :OilVcsStatusUpstreamUntracked}
                                       :status_priority {Status-type.Added 14
                                                         Status-type.Copied 13
                                                         Status-type.Deleted 14
                                                         Status-type.External 2
                                                         Status-type.Ignored 0
                                                         Status-type.Modified 14
                                                         Status-type.Renamed 13
                                                         Status-type.TypeChanged 13
                                                         Status-type.Unmerged 15
                                                         Status-type.Unmodified 2
                                                         Status-type.Untracked 1
                                                         Status-type.UpstreamAdded 4
                                                         Status-type.UpstreamCopied 3
                                                         Status-type.UpstreamDeleted 4
                                                         Status-type.UpstreamExternal 2
                                                         Status-type.UpstreamIgnored 0
                                                         Status-type.UpstreamModified 4
                                                         Status-type.UpstreamRenamed 3
                                                         Status-type.UpstreamTypeChanged 3
                                                         Status-type.UpstreamUnmerged 5
                                                         Status-type.UpstreamUnmodified 2
                                                         Status-type.UpstreamUntracked 1}
                                       :status_symbol {Status-type.Added :A
                                                       Status-type.Copied :C
                                                       Status-type.Deleted :D
                                                       Status-type.External :X
                                                       Status-type.Ignored "!"
                                                       Status-type.Modified :M
                                                       Status-type.Renamed :R
                                                       Status-type.TypeChanged :T
                                                       Status-type.Unmerged :U
                                                       Status-type.Unmodified " "
                                                       Status-type.Untracked "?"
                                                       Status-type.UpstreamAdded :A
                                                       Status-type.UpstreamCopied :C
                                                       Status-type.UpstreamDeleted :D
                                                       Status-type.UpstreamExternal :X
                                                       Status-type.UpstreamIgnored "!"
                                                       Status-type.UpstreamModified :M
                                                       Status-type.UpstreamRenamed :R
                                                       Status-type.UpstreamTypeChanged :T
                                                       Status-type.UpstreamUnmerged :U
                                                       Status-type.UpstreamUnmodified " "
                                                       Status-type.UpstreamUntracked "?"}
                                       :vcs_executable {:git :git :svn :svn}
                                       :vcs_specific {:git {:status_update_debounce 200}}})

