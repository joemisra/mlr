autowatch = 1;
inlets = 1;
outlets = 1;
var exportPatcher = this.patcher;
var task = new Task(runExport, this);
function folder() { return exportPatcher.filepath.replace(/^[^/]+:\//, "/").replace(/[^/]+$/, "") + "generated"; }
function bang() { task.cancel(); task.schedule(3000); }
function runExport() {
 var config = new Dict("mlr_dpt_bank_export_config");
 config.parse(JSON.stringify({output_path:folder(),export_name:"rnbo_source",minimal_export:true,
  copy_library:true,classname:"rnbomatic",fixedsamplerate:48000,fixedblocksize:48,
  openexportdirectory:false}));
 outlet(0,"export","cpp-export","cpp-code-export",config.name);
}
function exportstatus(status) {
 post("DPT bank export: " + status + "\n");
 var file = new File(folder()+"/status.txt", "write", "TEXT");
 if(file.isopen){file.writeline(String(status));file.close();}
}
