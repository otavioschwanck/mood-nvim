const {diagnosticManager, workspace, Position, commands, TextEdit} = require('coc.nvim')

exports.activate = async context => {
  let {nvim} = workspace
  context.subscriptions.push(commands.registerCommand('rubocop.insert', async () => {
    let [, line, ] = await nvim.eval('[coc#util#cursor(),getline("."),bufnr("%")]')

    let diagnostics = await diagnosticManager.getCurrentDiagnostics()

    if (diagnostics.length > 0) {
      let message = diagnostics[0].message.split(" ")[0]
      let parsedMessage = message.substr(1, message.length - 2)

      if (line.includes("# rubocop:disable")) {
        await nvim.call('setline', ['.', line + ", " + parsedMessage])
      } else {
        await nvim.call('setline', ['.', line + " # rubocop:disable " + parsedMessage])
      }
    }
  }))
}
