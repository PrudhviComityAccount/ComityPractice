trigger AccountTrigger on Account (before insert, before update, after insert, after update) {
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        for(Account a : Trigger.new) {
            if(a.Site == 'Atlanta' && a.AnnualRevenue > 500 && (a.NumberOfEmployees <0 || a.NumberofEmployees == null)){
                a.NumberofEmployees.addError('You should specify the no.of employees');
            }
        }
    }
}