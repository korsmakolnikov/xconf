(local dap (require :dap))

(set dap.adapters.lldb {:command :/usr/bin/lldb-vscode
                        :name :lldb
                        :type :executable})

(fn dap.configurations.env []
  (let [variables {}]
    (each [k v (pairs (vim.fn.environ))]
      (table.insert variables (string.format "%s=%s" k v)))
    variables))

(set dap.configurations.cpp [{:args {}
                              :cwd "${workspaceFolder}"
                              :name :Launch
                              :program (fn []
                                         (vim.fn.input "Path to executable: "
                                                       (.. (vim.fn.getcwd) "/")
                                                       :file))
                              :request :launch
                              :stopOnEntry false
                              :type :lldb}])

(set dap.configurations.c dap.configurations.cpp)

(set dap.configurations.rust dap.configurations.cpp)

((. (require :dapui) :setup))

;; TODO
;;(vim.keymap.set :n :<M-k> (. (require :dapui) :eval) {:buffer bufnr})

(fn dap.listeners.after.event_initialized.dapui_config []
  ((. (require :dapui) :open)))

(fn dap.listeners.before.event_terminated.dapui_config []
  ((. (require :dapui) :close)))

(fn dap.listeners.before.event_exited.dapui_config []
  ((. (require :dapui) :close)))

((. (require :dap-vscode-js) :setup) {:adapters [:chrome
                                                 :pwa-node
                                                 :pwa-chrome
                                                 :pwa-msedge
                                                 :node-terminal
                                                 :pwa-extensionHost
                                                 :node
                                                 :chrome]})

(local js-based-languages [:typescript :javascript :typescriptreact])

(each [_ language (ipairs js-based-languages)]
  (tset (. (require :dap) :configurations) language
        [{:cwd "${workspaceFolder}"
          :name "Launch file"
          :program "${file}"
          :request :launch
          :type :pwa-node}
         {:cwd "${workspaceFolder}"
          :name :Attach
          :processId (. (require :dap.utils) :pick_process)
          :request :attach
          :type :pwa-node}
         {:name "Start Chrome with \"localhost\""
          :request :launch
          :type :pwa-chrome
          :url "http://localhost:3000"
          :userDataDir "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
          :webRoot "${workspaceFolder}"}]))

