<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!--Modal: modalConfirmDelete-->
            <div class="modal fade" id="modWarningDel" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog modal-sm modal-notify modal-danger" role="document">
                    <!--Content-->
                    <div class="modal-content text-center">
                        <!--Header-->
                        <div class="modal-header d-flex justify-content-center">
                            <p class="heading">Are you sure?</p>
                        </div>
                        <!--Body-->
                        <div class="modal-body">
                            <i class="fas fa-times fa-4x"></i>
                        </div>
                        <!--Footer-->
                        <div class="modal-footer flex-center">
                            <button id="yes" href="" class="btn  btn-outline-danger">Yes</button>
                            <button type="button" class="btn  btn-danger waves-effect" data-dismiss="modal">No</button>
                        </div>
                    </div>
                    <!--/.Content-->
                </div>
            </div>
            <!--Modal: modalConfirmDelete-->
            <!--Modal: modalConfirmSuccess-->
            <div class="modal fade" id="modWarnSuccess" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog modal-sm modal-notify modal-success" role="document">
                    <!--Content-->
                    <div class="modal-content text-center">
                        <!--Header-->
                        <div class="modal-header d-flex justify-content-center">
                            <b class="heading">Success</b>
                        </div>
                        <!--Body-->
                        <div class="modal-body">
                            <i class="fas fa-check fa-4x animated rotateIn"></i>
                        </div>
                        <!--Footer-->
                        <div class="modal-footer flex-center">
                            <a type="button" class="btn  btn-success waves-effect" data-dismiss="modal">Ok</a>
                        </div>
                    </div>
                    <!--/.Content-->
                </div>
            </div>
            <!--Modal: modalConfirmSuccess-->

            <!--Modal Edit Question-->
                    <div class="modal fade " id="modEditQueSub">
                        <div class="modal-dialog cascading-modal" role="document">
                            <!--Content-->
                            <div class="modal-content">
                                <!--Modal cascading tabs-->
                                <div class="modal-c-tabs">
                                    <!-- Nav tabs -->
                                    <ul class="nav nav-tabs md-tabs tabs-2 light-blue darken-3" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link active" data-toggle="tab" href="#panel7" role="tab" style="background-color: #4285F4; color: white;"><i class="fas fa-pencil mr-1"></i><b>Edit Topic</b></a>
                                        </li>
                                    </ul>
                                    <!-- Tab panels -->
                                    <div class="tab-content">
                                        <div class="tab-pane fade in show active" role="tabpanel">
                                            <!--Body-->
                                            <form:form action="/editQ" method="POST" enctype="multipart/form-data">
                                            <div class="modal-body mb-1">
                                                <div class="md-form form-sm">
                                                    <div class="md-form md-outline">
                                                        <input type="hidden" name="id_question" />
                                                        <input type="hidden" name="tgl">
                                                        <input name="judul" id="Editquestion" type="text" max-length="50" class="form-control" autofocus="true">
                                                        <label for="question">Input Your Header Topic...</label>
                                                    </div>
                                                </div>
                                                <div class="md-form form-sm">
                                                    <div class="md-form md-outline">
                                                        <textarea name="konten" type="text" id="Editsubquestion" class="form-control" rows="3" autofocus="true"></textarea>
                                                        <label for="subquestion">Input Your Detail....</label>
                                                    </div>
                                                </div>
                                                <div class="md-form form-sm mb-1">
                                                    <div class="input-default-wrapper mt-3">
                                                        <input type="hidden" name="img">
                                                        <input name="imgQuestion" type="file" id="imgQuestion" class="input-default-js" accept="image/x-png,image/gif,image/jpeg">
                                                        <label class="label-for-default-js rounded-left rounded-right mb-3" for="imgQuestion"><span class="span-choose-file">Add Image</span>
                                                        </label>
                                                    </div>
                                                </div><br/><br/>
                                                <div class="md-form form-sm mb-1 text-center">
                                                    <button type="submit" id="btnAddTopic" class="btn btn-lg btn-deep-orange" style="color:white;"><i class="far fa-paper-plane"></i> Edit</button>
                                                </div>
                                            </div>
                                            </form:form>
                                            <!--Footer-->
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-danger btn-sm waves-effect ml-auto" data-dismiss="modal">Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--/.Content-->
                        </div>
                    </div>