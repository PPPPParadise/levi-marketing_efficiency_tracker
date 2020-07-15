from celery.decorators import task, periodic_task
from celery.utils.log import get_task_logger
from celery.task.schedules import crontab

from upload.utils import upload_excel_data,approve_data,send_reminder, check_procedure_status

logger = get_task_logger(__name__)


@task(name="my_schedule_task")
def my_schedule_task(temp,excel_type,country,currency,date,user):
    """sends an email when feedback form is filled successfully"""
    logger.info("upload file and Sent email for action taken")
    return upload_excel_data(temp,excel_type,country,currency,date,user)

@task(name="asyn_approve_task")
def asyn_approve_task(country,month,user,template_types_list,action_dict):
    """
    perform action
    """
    logger.info("perform action and send mail")
    return approve_data(country,month,user,template_types_list,action_dict)


@periodic_task(
    run_every=(crontab(day_of_week="1,3,5", hour=8,minute=20)),
    name="schedule_reminder",
    ignore_result=True
)
def schedule_reminder():
    """
    """
    send_reminder()
    logger.info("send reminder mail")

@periodic_task(
    run_every=(crontab(minute='*/1')),
    name="send_mail_for_new_entry",
    ignore_result=True
)
def send_mail_for_new_entry():
    """
    """
    check_procedure_status()
    logger.info("mail sent for new entry")