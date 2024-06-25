((. (require :oil) :setup) {:columns [:icon]
                            :default_file_explorer true
                            :delete_to_trash true
                            :float {:padding 10}
                            :view_options {:show_hidden true}
                            :win_options {:signcolumn :number}})

(require :oil_vcs)

(local oil-manager {})

(fn oil-manager.toggle_on_root_folder []
  (let [oil (require :oil)] (oil.toggle_float _G.Original_folder)))

(fn oil-manager.toggle_on_current_folder []
  (let [oil (require :oil)] (oil.toggle_float)))

oil-manager

